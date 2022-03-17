import 'package:flutter/material.dart';
import 'package:spotify/components/library/filter_button.dart';
import 'package:spotify/components/library/header.dart';
import 'package:spotify/components/library/view_mode.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final filterOptions = ['Playlists', 'Artists', 'Albums'];

  final playlists = [
    {
      'title': 'Liked Songs',
      'subtitle': 'Playlist',
      'cover': 'assets/images/favorite.png',
      'type': 'playlist'
    },
    {
      'title': 'Đen',
      'subtitle': 'Artist',
      'cover': 'assets/images/den-vau.jpeg',
      'type': 'artist'
    },
    {
      'title': 'Charlie Puth',
      'subtitle': 'Artist',
      'cover': 'assets/images/charlie-puth.jpeg',
      'type': 'artist'
    },
    {
      'title': 'Billie Eilish',
      'subtitle': 'Artist',
      'cover': 'assets/images/billie-eilish.jpeg',
      'type': 'artist'
    },
    {
      'title': 'Bích Phương',
      'subtitle': 'Artist',
      'cover': 'assets/images/bich-phuong.jpeg',
      'type': 'artist'
    },
    {
      'title': 'Maroon 5',
      'subtitle': 'Artist',
      'cover': 'assets/images/maroon5.jpeg',
      'type': 'artist'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LibraryHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: filterOptions
                        .map((option) => FilterButton(title: option))
                        .toList(),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: ViewModeSection(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      final cover = playlists[index]['cover'];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: ListTile(
                          title: Text(playlists[index]['title']!),
                          subtitle: Text(playlists[index]['subtitle']!),
                          leading: playlists[index]['type']! == 'playlist'
                              ? Image.asset(cover!)
                              : CircleAvatar(
                                  foregroundImage: AssetImage(cover!),
                                  radius: 28
                                ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
