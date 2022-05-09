import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/artist/back_button.dart';
import 'package:spotify/components/search/recent_search_item.dart';

import 'package:spotify/providers/data_provider.dart';

import '../components/library/close_button.dart';
import '../components/library/filter_button.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({Key? key}) : super(key: key);

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  final filterOptions = ['Playlists', 'Artists', 'Albums'];
  int _currentFilterOption = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = context
        .watch<DataProvider>()
        .recentPlayedList
        .where((element) =>
            _currentFilterOption == -1 ||
            filterOptions[_currentFilterOption]
                .toLowerCase()
                .contains('${element.runtimeType.toString().toLowerCase()}s'))
        .toList();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.red,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: const Center(
                        child: Text(
                          'Recently Played',
                          // style: Theme.of(context).textTheme.headline6,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const BackIconButton(),
                  ],
                ),
              ),
              _buildFiltersSection(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildRecentPlayedList(filteredList),
                      if (filteredList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, right: 10, top: 10),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<DataProvider>()
                                  .clearRecentPlayedList();
                            },
                            child: const Text(
                              'Clear history',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
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
      ),
    );
  }

  List<Widget> _buildRecentPlayedList(List list) {
    return list.map((item) {
      return GestureDetector(
        child: RecentSearchItem(
          id: item.id,
          title: item.name,
          subtitle: item.runtimeType.toString(),
          coverUrl: item.coverImageUrl,
          isSquareCover: item.runtimeType.toString() != 'Artist',
          onPressed: () {
            context.read<DataProvider>().deleteFromPlayedList(item);
          },
        ),
      );
    }).toList();
  }
  // Widget _buildListView(List list) {
  //   return ListView.builder(
  //     itemCount: list.length,
  //     itemBuilder: (context, index) {
  //       final item = list[index];
  //       return item.runtimeType.toString() == 'Song'
  //           ? SongSearch(
  //         song: item,
  //         trailing: ActionButton(
  //           song: item,
  //           size: 20,
  //           onPressed: () {
  //             Navigator.of(context, rootNavigator: true).push(
  //               MaterialPageRoute(
  //                 builder: (context) => SongAction(song: item),
  //               ),
  //             );
  //           },
  //         ),
  //       )
  //           : GestureDetector(
  //         child: SearchItem(
  //           title: item.name,
  //           subtitle: item.runtimeType.toString(),
  //           coverUrl: item.coverImageUrl,
  //           isSquareCover: item.runtimeType.toString() != 'Artist',
  //         ),
  //         onTap: () => onTap(item),
  //       );
  //     },
  //   );
  // }

  // void onTap(item) {
  //   context.read<DataProvider>().addToRecentSearchList(item);
  //   final image = getImageFromUrl(item.coverImageUrl);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) {
  //         switch (item.runtimeType.toString()) {
  //           case 'Playlist':
  //             return PlaylistView(
  //               id: item.id,
  //               image: image,
  //               label: item.name,
  //               songIdList: item.songIdList,
  //             );
  //
  //           case 'Album':
  //             return AlbumView(
  //               id: item.id,
  //               image: image,
  //               label: item.name,
  //               description: item.description,
  //               songIdList: item.songIdList,
  //             );
  //
  //           default:
  //             return ArtistView(
  //               id: item.id,
  //               image: image,
  //               label: item.name,
  //               description: item.description,
  //               songIdList: item.songIdList,
  //             );
  //         }
  //       },
  //     ),
  //   );
  // }
}
