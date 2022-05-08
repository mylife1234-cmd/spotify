import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/home/artist_card.dart';
import 'package:spotify/components/home/home_header.dart';
import 'package:spotify/components/home/playlist_card.dart';
import 'package:spotify/pages/loading.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/utils/helper.dart';

import '../components/home/album_card.dart';
import '../main.dart';
import '../utils/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getIt.registerSingleton<BuildContext>(context, instanceName: 'homeContext');
  }

  @override
  Widget build(BuildContext context) {
    final recentPlaylists = context.watch<DataProvider>().recentPlaylists;
    final systemPlaylists = context.watch<DataProvider>().systemPlaylists;
    final recentAlbum = context.watch<DataProvider>().recentAlbums;
    final favoriteArtists = context.watch<DataProvider>().favoriteArtists;

    final List recentList = [...recentPlaylists, ...recentAlbum]..shuffle();

    final List recommendedList = [...favoriteArtists, ...systemPlaylists];

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
                // SizedBox(height: 20),
                ...recentList.isNotEmpty
                    ? [
                        const HomeHeader(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: recentList.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: item.runtimeType.toString() == 'Playlist'
                                    ? PlaylistCard(
                                        id: item.id,
                                        label: item.name,
                                        image:
                                            getImageFromUrl(item.coverImageUrl),
                                        songIdList: item.songIdList,
                                      )
                                    : FutureBuilder(
                                        future: Database.getArtistName(
                                            item.artistId),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return AlbumCard(
                                              id: item.id,
                                              label: item.name,
                                              image: getImageFromUrl(
                                                  item.coverImageUrl),
                                              songIdList: item.songIdList,
                                              description: snapshot.data,
                                            );
                                          }
                                          return AlbumCard(
                                            id: item.id,
                                            label: item.name,
                                            image: getImageFromUrl(
                                                item.coverImageUrl),
                                            songIdList: item.songIdList,
                                            description: item.description,
                                          );
                                        },
                                      ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ]
                    : [const SizedBox()],

                ...['Uniquely yours', 'Made for you'].map((e) {
                  final length = recommendedList.length ~/ 2;

                  final shuffledList = [...recommendedList]..shuffle();

                  final list = shuffledList.sublist(0, length);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: list.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: item.runtimeType.toString() == 'Playlist'
                                    ? PlaylistCard(
                                        id: item.id,
                                        label: item.name,
                                        image:
                                            getImageFromUrl(item.coverImageUrl),
                                        songIdList: item.songIdList,
                                      )
                                    : ArtistCard(
                                        id: item.id,
                                        label: item.name,
                                        image:
                                            getImageFromUrl(item.coverImageUrl),
                                        description: item.description,
                                        songIdList: item.songIdList,
                                      ),
                              );
                            }).toList(),
                          ),
                        ),
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
}
