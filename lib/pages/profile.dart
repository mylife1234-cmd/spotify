import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/profile/profile_component.dart';
import 'package:spotify/components/profile/profile_image.dart';
import 'package:spotify/pages/playlist_view.dart';
import 'package:spotify/utils/helper.dart';

import '../components/library/list_item.dart';
import '../providers/data_provider.dart';
import 'artist_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.image, required this.label})
      : super(key: key);

  final ImageProvider image;
  final String label;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final favoritePlaylists = [
      ...context.watch<DataProvider>().favoritePlaylists,
    ];
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ProfileImage(
                                imageSize: 130,
                                image: widget.image,
                                imageOpacity: 1,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 20),
                                child: Column(
                                  children: [
                                    ProfileComponent(
                                      label: widget.label,
                                      image: widget.image,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: favoritePlaylists.map((item) {
                                  return GestureDetector(
                                    child: ListItem(
                                      title: item.name,
                                      subtitle: item.runtimeType.toString(),
                                      coverUrl: item.coverImageUrl,
                                      isSquareCover:
                                          item.runtimeType.toString() !=
                                              'Artist',
                                    ),
                                    onTap: () {
                                      onTap(item);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            if (favoritePlaylists.length == 3)
                              const SizedBox(height: 140),
                            if (favoritePlaylists.length == 2)
                              const SizedBox(height: 200),
                            if (favoritePlaylists.length == 1)
                              const SizedBox(height: 250)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
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
