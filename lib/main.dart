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
import 'package:spotify/providers/music_provider.dart';

import 'utils/music/audio_handler.dart';

GetIt getIt = GetIt.instance;

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  getIt.registerSingleton<AudioHandler>(await initAudioService());

  runApp(ChangeNotifierProvider<MusicProvider>(
    child: const MyApp(),
    create: (_) => MusicProvider(),
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

  bool authenticated = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        authenticated = user != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _currentSong = context.watch<MusicProvider>().currentSong;

    if (!authenticated) {
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
}
