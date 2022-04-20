import 'package:flutter/material.dart';
import 'package:spotify/components/library/grid_item.dart';
import 'package:spotify/components/library/list_item.dart';
import 'package:spotify/pages/playlist_view.dart';
import 'artist_view.dart';

class SearchPlayList extends StatefulWidget {
  const SearchPlayList({Key? key}) : super(key: key);

  @override
  State<SearchPlayList> createState() => _SearchPlayListState();
}

class _SearchPlayListState extends State<SearchPlayList> {
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
  List searchRecent = [];
  String searchString = '';
  final bool _showAsList = true;

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
                      height: 36,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        textAlign: TextAlign.left,
                        onChanged: _runSearch,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          fillColor: const Color.fromRGBO(36, 36, 36, 1),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          ),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        cursorColor: const Color(0xff57b660),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                ),
                const Text(
                  'Recent searches',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
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
  void initState() {
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
              user['title'].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      recentSearch = results;
    });
  }

  Widget _buildListView() {
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

  Widget _buildGridView() {
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
