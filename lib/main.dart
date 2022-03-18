import 'package:flutter/material.dart';
import 'package:spotify/components/player/miniplayer.dart';
import 'package:spotify/pages/home.dart';
import 'package:spotify/pages/library.dart';
import 'package:spotify/pages/search.dart';

void main() {
  runApp(const MyApp());
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
  final pages = [const HomePage(), const SearchPage(), const LibraryPage()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music), label: 'Your Library')
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: pages[_currentIndex],
        ),
        const Align(
          child: MiniPlayer(),
          alignment: Alignment.bottomCenter,
        )
      ]),
    );
  }
}
