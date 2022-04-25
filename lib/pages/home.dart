import 'package:flutter/material.dart';
import 'package:spotify/components/home/home_header.dart';
import 'package:spotify/components/home/playlist_card.dart';
import 'package:spotify/models/playlist.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Playlist>? systemPlaylists;
  List<Playlist>? recentPlaylists;

  @override
  void initState() {
    super.initState();

    getIt.registerSingleton<BuildContext>(context, instanceName: 'homeContext');

    //temp
    final playlists = getIt.get<Map<String, List<Playlist>>>();
    setState(() {
      systemPlaylists = playlists['systemPlaylists'];
      recentPlaylists = playlists['recentPlaylists'];
    });
  }

  @override
  Widget build(BuildContext context) {
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
        // Xu ly man hinh vuot qua do dao
        SafeArea(
          child: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 20),
                const HomeHeader(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recentPlaylists!.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: PlaylistCard(
                          id: item.id,
                          label: item.name,
                          image: NetworkImage(item.coverImageUrl),
                          songIdList: item.songIdList,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 15),

                ...['Uniquely yours', 'Made for you'].map((e) {
                  final shuffledList = (systemPlaylists ?? [])
                    ..sublist(0)
                    ..shuffle();

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
                            children: shuffledList
                                .sublist(0, shuffledList.length)
                                .map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: PlaylistCard(
                                  id: item.id,
                                  label: item.name,
                                  image: NetworkImage(item.coverImageUrl),
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
