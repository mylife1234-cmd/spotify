import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/search/search_item.dart';
import 'package:spotify/components/search/song_search.dart';
import 'package:spotify/pages/playlist_view.dart';
import 'package:spotify/providers/data_provider.dart';
import '../utils/helper.dart';
import 'album_view.dart';
import 'artist_view.dart';

class SearchAll extends StatefulWidget {
  const SearchAll({Key? key}) : super(key: key);

  @override
  State<SearchAll> createState() => _SearchAllState();
}

class _SearchAllState extends State<SearchAll> {
  @override
  void initState() {
    // at the beginning, all users are shown
    recentSearch = playlists;
    super.initState();
  }
  

  List playlists = [];
  List recentSearch = [];
  List searchRecent = [];
  String searchString = '';

  @override
  Widget build(BuildContext context) {
    playlists = [
      ...context.watch<DataProvider>().albums,
      ...context.watch<DataProvider>().artists,
      ...context.watch<DataProvider>().songs
    ];

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
                  child: _buildListView(recentSearch, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _runSearch(String keyword) {
    List results = [];
    if (keyword.isEmpty) {
      results = playlists;
    } else {
      results = playlists
          .where((user) =>
              user.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      recentSearch = results;
    });
  }

  Widget _buildListView(list, BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return item.runtimeType.toString() == 'Song' ?
           SongSearch(song: item)
          
        :  GestureDetector(
          child: SearchItem(
            title: item.name,
            subtitle: item.runtimeType.toString(),
            coverUrl: item.coverImageUrl,
            isSquareCover: item.runtimeType.toString() != 'Artist',
          ),
          onTap: () {
            onTap(item);
          },
        );
      },
    );
  }

  void onTap(item) {
    final image = getImageFromUrl(item.coverImageUrl);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (item.runtimeType.toString() == 'Playlist') {
            return PlaylistView(
                id: item.id,
                image: image,
                label: item.name,
                songIdList: item.songIdList);
          }
          if (item.runtimeType.toString() == 'Album') {
            return AlbumView(
                id: item.id,
                image: image,
                label: item.name,
                description: item.description,
                songIdList: item.songIdList);
          }
          return ArtistView(
              id: item.id,
              image: image,
              label: item.name,
              description: item.description,
              songIdList: item.songIdList);
        },
      ),
    );
  }
}


