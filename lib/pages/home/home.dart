import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/home/artist_card.dart';
import 'package:spotify/components/home/header_buttons.dart';
import 'package:spotify/components/home/home_header.dart';
import 'package:spotify/components/home/playlist_card.dart';
import 'package:spotify/pages/others/loading.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/utils/helper.dart';

import '../../components/home/album_card.dart';
import '../../utils/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sections = ['Uniquely yours', 'Made for you', 'Recommended for today'];

  @override
  Widget build(BuildContext context) {
    final recentPlayedList = context.watch<DataProvider>().recentPlayedList;
    final systemPlaylists = context.watch<DataProvider>().systemPlaylists;
    // final favoriteArtists = context.watch<DataProvider>().favoriteArtists;
    final albums = context.watch<DataProvider>().albums;
    final artists = context.watch<DataProvider>().artists;
    final List recommendedList = [...artists, ...systemPlaylists, ...albums];

    if (recommendedList.isEmpty) {
      return const LoadingScreen();
    }

    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(1),
              ],
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...recentPlayedList.isNotEmpty
                    ? [
                        const HomeHeader(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: recentPlayedList.length < 12
                              ? _buildRowItem(recentPlayedList)
                              : _buildRowItem(
                                  recentPlayedList.sublist(0, 12),
                                ),
                        ),
                      ]
                    : [const SizedBox()],
                const SizedBox(height: 15),
                ...sections.map((e) {
                  // final length = recommendedList.length ~/ 5;
                  const length = 8;

                  final shuffledList = [...recommendedList]..shuffle();

                  final list = shuffledList.sublist(0, length);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 9, bottom: 15),
                            child: Text(
                              e,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (recentPlayedList.isEmpty &&
                              sections.indexOf(e) == 0)
                            const HeaderButtons()
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: _buildRowItem(list)),
                      )
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildRowItem(List list) {
    return Row(
      children: list.map<Widget>((item) {
        switch (item.runtimeType.toString()) {
          case 'Playlist':
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: PlaylistCard(
                playlist: item,
                image: getImageFromUrl(item.coverImageUrl),
                size: 120,
              ),
            );
          case 'Artist':
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ArtistCard(
                id: item.id,
                label: item.name,
                image: getImageFromUrl(item.coverImageUrl),
                description: item.description,
                songIdList: item.songIdList,
                size: 120,
              ),
            );
          default:
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: FutureBuilder(
                future: Database.getArtistName(item.artistId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return AlbumCard(
                      album: item,
                      image: getImageFromUrl(item.coverImageUrl),
                      description: snapshot.data,
                      size: 120,
                    );
                  }
                  return AlbumCard(
                    album: item,
                    image: getImageFromUrl(item.coverImageUrl),
                    description: item.description,
                    size: 120,
                  );
                },
              ),
            );
        }
      }).toList(),
    );
  }
}
