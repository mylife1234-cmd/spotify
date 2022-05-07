import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/search/recent_search_item.dart';
import 'package:spotify/components/search/search_item.dart';
import 'package:spotify/components/search/song_search.dart';
import 'package:spotify/pages/playlist_view.dart';
import 'package:spotify/providers/data_provider.dart';

import '../components/library/close_button.dart';
import '../components/library/filter_button.dart';
import '../components/search/recent_song_search.dart';
import '../utils/helper.dart';
import 'album_view.dart';
import 'artist_view.dart';

class SearchAll extends StatefulWidget {
  const SearchAll({Key? key}) : super(key: key);

  @override
  State<SearchAll> createState() => _SearchAllState();
}

class _SearchAllState extends State<SearchAll> {
  final filterOptions = ['Top', 'Playlists', 'Songs', 'Artists', 'Albums'];
  int _currentFilterOption = 0;
  List playlists = [];
  List recentSearch = [];
  List searchResult = [];
  bool isSearch = false;

  @override
  void initState() {
    isSearch = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    playlists = [
      ...context.watch<DataProvider>().albums,
      ...context.watch<DataProvider>().artists,
      ...context.watch<DataProvider>().songs
    ];
    recentSearch = [
      ...context.watch<DataProvider>().recentSearchList,
    ];
    final filteredList = searchResult
        .where((element) =>
            _currentFilterOption == 0 ||
            filterOptions[_currentFilterOption]
                .toLowerCase()
                .contains('${element.runtimeType.toString().toLowerCase()}s'))
        .toList();
    // filteredList.sort((a, b) => a.name.compareTo(b.name));
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
                      height: 38,
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
                if (isSearch)
                  _buildFiltersSection()
                else
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 10, top: 20),
                    child: Text(
                      'Recent searches',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Expanded(
                  child: isSearch
                      ? _buildListView(filteredList, context)
                      : _buildRecentListView(recentSearch, context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFiltersSection() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
        child: Row(
          children: _currentFilterOption == 0
              ? filterOptions
                  .map((option) => GestureDetector(
                        child: FilterButton(
                          title: option,
                          active: false,
                        ),
                        onTap: () => setState(() {
                          _currentFilterOption = filterOptions.indexOf(option);
                        }),
                      ))
                  .toList()
              : [
                  GestureDetector(
                    child: const CustomCloseButton(),
                    onTap: () => setState(() {
                      _currentFilterOption = 0;
                    }),
                  ),
                  GestureDetector(
                    child: FilterButton(
                      title: filterOptions[_currentFilterOption],
                      active: true,
                    ),
                    onTap: () => setState(() {
                      _currentFilterOption = 0;
                    }),
                  ),
                ],
        ),
      ),
    );
  }

  void _runSearch(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        isSearch = false;
      });
    } else {
      playlists.sort((a, b) => a.name.compareTo(b.name));
      final subListOne = playlists
          .where((element) =>
              element.name.toLowerCase().contains(keyword.toLowerCase()) &&
              !element.name.toLowerCase().startsWith(keyword))
          .toList();
      final subListTwo = playlists
          .where((element) => element.name.toLowerCase().startsWith(keyword))
          .toList();
      final results = [...subListTwo, ...subListOne];
      setState(() {
        isSearch = true;
        searchResult = results;
      });
    }
  }

  Widget _buildListView(list, BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return item.runtimeType.toString() == 'Song'
            ? SongSearch(song: item)
            : GestureDetector(
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

  Widget _buildRecentListView(list, BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return item.runtimeType.toString() == 'Song'
            ? RecentSongSearch(
                song: item,
                id: item.id,
                onPressed: () {
                  context
                      .read<DataProvider>()
                      .recentSearchList
                      .removeWhere((element) => element.id == item.id);
                  setState(() {});
                },
              )
            : GestureDetector(
                child: RecentSearchItem(
                  id: item.id,
                  title: item.name,
                  subtitle: item.runtimeType.toString(),
                  coverUrl: item.coverImageUrl,
                  isSquareCover: item.runtimeType.toString() != 'Artist',
                  onPressed: () {
                    context
                        .read<DataProvider>()
                        .recentSearchList
                        .removeWhere((element) => element.id == item.id);
                    setState(() {});
                  },
                ),
                onTap: () {
                  onTap(item);
                },
              );
      },
    );
  }

  void onTap(item) {
    if (!recentSearch.any((element) => element.id == item.id)){
      context.read<DataProvider>().recentSearchList.add(item);
    }
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
