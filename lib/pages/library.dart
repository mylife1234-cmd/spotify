import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/library/close_button.dart';
import 'package:spotify/components/library/filter_button.dart';
import 'package:spotify/components/library/grid_item.dart';
import 'package:spotify/components/library/header.dart';
import 'package:spotify/components/library/list_item.dart';
import 'package:spotify/components/library/view_mode.dart';
import 'package:spotify/models/playlist.dart';
import 'package:spotify/pages/playlist_creation.dart';
import 'package:spotify/pages/playlist_view.dart';

import '../providers/data_provider.dart';
import '../utils/helper.dart';
import 'album_view.dart';
import 'artist_view.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final filterOptions = ['Playlists', 'Artists', 'Albums'];

  int _currentFilterOption = -1;

  bool _showAsList = true;

  int _sortOption = 0;

  @override
  Widget build(BuildContext context) {
    final favoritePlaylists = context.watch<DataProvider>().favoritePlaylists;

    final favoriteArtists = context.watch<DataProvider>().favoriteArtists;

    final favoriteAlbums = context.watch<DataProvider>().favoriteAlbums;

    final favoriteSongs = context.watch<DataProvider>().favoriteSongs;

    final Playlist likedSongs = Playlist(
      id: context.watch<DataProvider>().user.id,
      name: 'Liked Songs',
      coverImageUrl: 'assets/images/favorite.png',
      songIdList: favoriteSongs.map((e) => e.id).toList(),
      type: 'user',
    );

    final List list = [
      ...favoritePlaylists,
      ...favoriteArtists,
      ...favoriteAlbums,
      likedSongs
    ];

    final filteredList = list
        .where((element) =>
            _currentFilterOption == -1 ||
            filterOptions[_currentFilterOption]
                .toLowerCase()
                .contains('${element.runtimeType.toString().toLowerCase()}s'))
        .toList();

    if (_sortOption == 0) {
      filteredList.sort((a, b) => a.name.compareTo(b.name));
    } else {
      filteredList.sort((a, b) => -a.name.compareTo(b.name));
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LibraryHeader(
                  handleAdding: () {
                    showCupertinoModalBottomSheet(
                      useRootNavigator: true,
                      context: context,
                      builder: (context) {
                        return PlaylistCreationPage(
                          handlePlaylistCreation: (newPlaylist) {
                            // setState(() {
                            //   playlists = [...playlists, newPlaylist];
                            // });
                          },
                        );
                      },
                      duration: const Duration(milliseconds: 250),
                    );
                  },
                ),
                _buildFiltersSection(),
                _buildViewModesSection(),
                Expanded(
                  child: _showAsList
                      ? _buildListView(filteredList)
                      : _buildGridView(filteredList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: _currentFilterOption == -1
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
                    _currentFilterOption = -1;
                  }),
                ),
                GestureDetector(
                  child: FilterButton(
                    title: filterOptions[_currentFilterOption],
                    active: true,
                  ),
                  onTap: () => setState(() {
                    _currentFilterOption = -1;
                  }),
                ),
              ],
      ),
    );
  }

  Widget _buildViewModesSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ViewModeSection(
        handleViewMode: () => setState(() {
          _showAsList = !_showAsList;
        }),
        showAsList: _showAsList,
        handleSortOption: (newOption) => setState(() {
          _sortOption = newOption;
        }),
        sortOption: _sortOption,
      ),
    );
  }

  Widget _buildListView(list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        return GestureDetector(
          child: ListItem(
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

  Widget _buildGridView(list) {
    final width = MediaQuery.of(context).size.width;

    final cardWidth = (width - 35) / 2;

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: cardWidth / (cardWidth + 60),
      children: list.map<Widget>((item) {
        return GestureDetector(
          child: GridItem(
            title: item.name,
            subtitle: item.runtimeType.toString(),
            coverUrl: item.coverImageUrl,
            isSquareCover: item.runtimeType.toString() != 'Artist',
          ),
          onTap: () {
            onTap(item);
          },
        );
      }).toList(),
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
