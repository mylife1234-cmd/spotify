import 'package:audio_service/audio_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/player/mini_player.dart';
import 'package:spotify/pages/home.dart';
import 'package:spotify/pages/library.dart';
import 'package:spotify/pages/search.dart';
import 'package:spotify/pages/start.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/providers/music_provider.dart';
import 'package:spotify/utils/firebase/db.dart';

import 'utils/music/audio_handler.dart';

GetIt getIt = GetIt.instance;

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  getIt.registerSingleton<AudioHandler>(await initAudioService());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MusicProvider()),
      ChangeNotifierProvider(create: (_) => DataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          backgroundColor: Colors.black,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const Main(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final _tabs = [const HomePage(), const SearchPage(), const LibraryPage()];

  final _tabNavKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final _tabController = CupertinoTabController();

  int _currentIndex = 0;

  bool _authenticated = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _authenticated = user != null;
      });

      if (user != null) {
        getUserData(user.uid, user.displayName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _currentSong = context.watch<MusicProvider>().currentSong;

    if (!_authenticated) {
      return const StartPage();
    }

    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Your Library',
          )
        ],
        iconSize: 24,
        activeColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      tabBuilder: (context, index) {
        return _currentSong == null
            ? CupertinoTabView(
                navigatorKey: _tabNavKeys[index],
                builder: (context) =>
                    CupertinoPageScaffold(child: _tabs[index]),
              )
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 64),
                    child: CupertinoTabView(
                      navigatorKey: _tabNavKeys[index],
                      builder: (context) =>
                          CupertinoPageScaffold(child: _tabs[index]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(child: MiniPlayer(song: _currentSong)),
                  )
                ],
              );
      },
    );
  }

  Future<void> getUserData(String id, String? name) async {
    final user = await Database.getUserById(id, name!);

    context.read<DataProvider>().setUser(user);

    Future.wait(
      user.systemPlaylistIdList.map((id) => Database.getPlaylistById(id)),
    ).then(
      (playlists) => context.read<DataProvider>().addSystemPlaylists(playlists),
    );

    Future.wait(
      user.recentPlaylistIdList.map((id) => Database.getPlaylistById(id)),
    ).then(
      (playlists) => context.read<DataProvider>().addRecentPlaylists(playlists),
    );

    Future.wait(
      user.favoritePlaylistIdList.map((id) => Database.getPlaylistById(id)),
    ).then(
      (playlists) =>
          context.read<DataProvider>().addFavoritePlaylists(playlists),
    );

    Future.wait(
      user.customizedPlaylistIdList.map((id) => Database.getPlaylistById(id)),
    ).then(
      (playlists) =>
          context.read<DataProvider>().addCustomizedPlaylists(playlists),
    );

    Future.wait(
      user.recentSongIdList.map((id) => Database.getSongById(id)),
    ).then(
      (songs) => context.read<DataProvider>().addRecentSongs(songs),
    );

    Future.wait(
      user.favoriteSongIdList.map((id) => Database.getSongById(id)),
    ).then(
      (songs) => context.read<DataProvider>().addFavoriteSongs(songs),
    );

    Future.wait(
      user.recentAlbumIdList.map((id) => Database.getAlbumById(id)),
    ).then(
      (albums) => context.read<DataProvider>().addRecentAlbums(albums),
    );

    Future.wait(
      user.favoriteAlbumIdList.map((id) => Database.getAlbumById(id)),
    ).then(
      (albums) => context.read<DataProvider>().addFavoriteAlbums(albums),
    );

    Database.getGenres().then((genres) {
      context.read<DataProvider>().addGenres(genres);
    });

    Database.getAlbums().then((albums) {
      context.read<DataProvider>().addAlbums(albums);
    });

    Database.getArtists().then((artists) {
      context.read<DataProvider>().addArtists(artists);
    });
  }
}
