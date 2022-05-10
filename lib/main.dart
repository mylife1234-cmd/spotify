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
import 'package:spotify/utils/db.dart';

import 'utils/audio_handler.dart';

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

final tabNavKeys = [
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
];

final tabController = CupertinoTabController();

class _MainState extends State<Main> {
  final _tabs = [const HomePage(), const SearchPage(), const LibraryPage()];

  int _currentIndex = 0;

  bool _authenticated = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!user!.emailVerified) {
        user.sendEmailVerification().whenComplete(() {
          authenticate(user);
        });
      } else {
        authenticate(user);
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
      controller: tabController,
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (_currentIndex == index) {
            tabNavKeys[index].currentState!.popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
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
                navigatorKey: tabNavKeys[index],
                builder: (context) =>
                    CupertinoPageScaffold(child: _tabs[index]),
              )
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 64),
                    child: CupertinoTabView(
                      navigatorKey: tabNavKeys[index],
                      builder: (context) =>
                          CupertinoPageScaffold(child: _tabs[index]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: MiniPlayer(song: _currentSong),
                    ),
                  )
                ],
              );
      },
    );
  }

  void authenticate(User user) {
    setState(() {
      _authenticated = user.emailVerified;
    });

    if (user.emailVerified) {
      getUserData(user.uid, user.displayName, user.photoURL);
    }
  }

  Future<void> getUserData(String id, String? name, String? avatarUrl) async {
    final user = await Database.getUserById(id, name!, avatarUrl);

    context.read<DataProvider>().setUser(user);

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
      user.favoriteSongIdList.map((id) => Database.getSongById(id)),
    ).then(
      (songs) => context.read<DataProvider>().addFavoriteSongs(songs),
    );

    Future.wait(
      user.favoriteAlbumIdList.map((id) => Database.getAlbumById(id)),
    ).then(
      (albums) => context.read<DataProvider>().addFavoriteAlbums(albums),
    );

    Future.wait(
      user.favoriteArtistIdList.map((id) => Database.getArtistById(id)),
    ).then(
      (artists) => context.read<DataProvider>().addFavoriteArtists(artists),
    );

    Future.wait(user.recentSearchIdList.map(
      (id) {
        if (id.toString().contains('song-')) {
          final idSplit = id.toString().split('-');
          return Database.getSongById(idSplit[1]);
        }
        if (id.toString().contains('album-')) {
          final idSplit = id.toString().split('-');
          return Database.getAlbumById(idSplit[1]);
        }
        if (id.toString().contains('artist-')) {
          final idSplit = id.toString().split('-');
          return Database.getArtistById(idSplit[1]);
        }
        return Database.getPlaylistById(id.toString().split('-')[1]);
      },
    )).then(
      (list) => context.read<DataProvider>().addRecentSearchList(list),
    );

    Future.wait(user.recentPlayedIdList.map(
      (id) {
        if (id.toString().contains('album-')) {
          final idSplit = id.toString().split('-');
          return Database.getAlbumById(idSplit[1]);
        }

        if (id.toString().contains('playlist-')) {
          final idSplit = id.toString().split('-');
          return Database.getPlaylistById(idSplit[1]);
        }
        return Database.getArtistById(id.toString().split('-')[1]);
      },
    )).then(
      (list) => context.read<DataProvider>().addRecentPlayedList(list),
    );

    await Database.getGenres().then((genres) {
      context.read<DataProvider>().addGenres(genres);
    });

    await Database.getAlbums().then((albums) {
      context.read<DataProvider>().addAlbums(albums);
    });

    await Database.getSystemPlaylistList().then((playlists) {
      context.read<DataProvider>().addSystemPlaylists(playlists);
    });

    await Database.getArtists().then((artists) {
      context.read<DataProvider>().addArtists(artists);
    });

    await Database.getSongs().then((songs) {
      context.read<DataProvider>().addSongs(songs);
    });
  }
}
