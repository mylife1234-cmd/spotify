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

import 'artist_view.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final filterOptions = ['Playlists', 'Artists', 'Albums'];

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

  int _currentFilterOption = -1;

  bool _showAsList = true;

  int _sortOption = 0;

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
                LibraryHeader(
                  handleAdding: () {
                    showCupertinoModalBottomSheet(
                      useRootNavigator: true,
                      context: context,
                      builder: (context) {
                        return PlaylistCreationPage(
                          handlePlaylistCreation: (newPlaylist) {
                            setState(() {
                              playlists = [...playlists, newPlaylist];
                            });
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
                  child: _showAsList ? _buildListView() : _buildGridView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFiltersSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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

  _buildViewModesSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
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

  _buildListView() {
    final filteredList = playlists
        .where(
          (element) =>
              _currentFilterOption == -1 ||
              filterOptions[_currentFilterOption]
                  .toLowerCase()
                  .contains(element['type']!),
        )
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final item = filteredList[index];

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
    final filteredList = playlists
        .where((element) =>
            _currentFilterOption == -1 ||
            filterOptions[_currentFilterOption]
                .toLowerCase()
                .contains(element['type']!))
        .toList();

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.75,
      children: filteredList
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
