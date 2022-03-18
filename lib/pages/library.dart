import 'package:flutter/material.dart';
import 'package:spotify/components/library/close_button.dart';
import 'package:spotify/components/library/filter_button.dart';
import 'package:spotify/components/library/grid_item.dart';
import 'package:spotify/components/library/header.dart';
import 'package:spotify/components/library/list_item.dart';
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

  int _currentFilterOption = -1;

  bool _showAsList = true;

  int _sortOption = 0;

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
    final list = playlists
        .where((element) =>
            _currentFilterOption == -1 ||
            filterOptions[_currentFilterOption]
                .toLowerCase()
                .contains(element['type']!))
        .toList();

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        return ListItem(
          title: item['title']!,
          subtitle: item['subtitle']!,
          coverUrl: item['cover']!,
          isSquareCover: item['type']! == 'playlist',
        );
      },
    );
  }

  _buildGridView() {
    final list = playlists
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
      children: list
          .map(
            (item) => GridItem(
              title: item['title']!,
              subtitle: item['subtitle']!,
              coverUrl: item['cover']!,
              isSquareCover: item['type']! == 'playlist',
            ),
          )
          .toList(),
    );
  }
}
