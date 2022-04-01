import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotify/components/library/close_button.dart';
import 'package:spotify/components/library/filter_button.dart';
import 'package:spotify/components/library/grid_item.dart';
import 'package:spotify/components/library/header.dart';
import 'package:spotify/components/library/list_item.dart';
import 'package:spotify/components/library/view_mode.dart';
import 'package:spotify/pages/playlist_creation.dart';
import 'package:spotify/pages/playlist_view.dart';
import 'package:spotify/pages/search.dart';
import 'album_view.dart';
import 'artist_view.dart';

class SearchPlayList extends StatefulWidget {
  const SearchPlayList({Key? key}) : super(key: key);

  @override
  State<SearchPlayList> createState() => _SearchPlayListState();
}

class _SearchPlayListState extends State<SearchPlayList> {
  final filterOptions = [];

  List playlists = [
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
  List recentSearch = [];
  String searchString = "";
  bool _showAsList = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 33,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        textAlign: TextAlign.left,
                        onChanged: (value) => _runSearch(value),
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          fillColor: Color.fromRGBO(58, 58, 58, 1.0),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 15.0,
                          ),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 0.0),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SearchPage()));
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                ),
                Text(
                  'Recent searches',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                ),
                Expanded(
                  child: _showAsList ? _buildListView() : _buildGridView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    // at the beginning, all users are shown
    recentSearch = playlists;
    super.initState();
  }

  void _runSearch(String keyword) {
    List results = [];
    if (keyword.isEmpty) {
      results = playlists;
    } else {
      results = playlists
          .where((user) =>
              user["title"].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      recentSearch = results;
    });
  }

  _buildListView() {
    return ListView.builder(
      itemCount: recentSearch.length,
      itemBuilder: (context, index) {
        final item = recentSearch[index];

        return GestureDetector(
          child: ListItem(
            title: item['title']!,
            subtitle: item['subtitle']!,
            coverUrl: item['cover']!,
            isSquareCover: item['type']! == 'playlist',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => item['type'] == 'playlist'
                    ? PlaylistView(
                        image: AssetImage(item['cover']),
                        label: item['title'],
                      )
                    : ArtistView(
                        image: AssetImage(item['cover']),
                        label: item['title'],
                      ),
              ),
            );
          },
        );
      },
    );
  }

  _buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.75,
      children: recentSearch
          .map(
            (item) => GestureDetector(
              child: GridItem(
                title: item['title']!,
                subtitle: item['subtitle']!,
                coverUrl: item['cover']!,
                isSquareCover: item['type']! == 'playlist',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => item['type'] == 'playlist'
                        ? PlaylistView(
                            image: AssetImage(item['cover']),
                            label: item['title'],
                          )
                        : ArtistView(
                            image: AssetImage(item['cover']),
                            label: item['title'],
                          ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
