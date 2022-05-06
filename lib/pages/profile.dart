import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/album/animate_label.dart';

import 'package:spotify/components/artist/back_button.dart';
import 'package:spotify/components/profile/profile_component.dart';
import 'package:spotify/components/profile/profile_image.dart';
import 'package:spotify/pages/playlist_view.dart';
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
  late ScrollController scrollController;
  double imageSize = 0;
  double initialImageSize = 150;
  double containerHeight = 300;
  double containerInitialHeight = 300;
  double imageOpacity = 1;
  bool showTopBar = false;
  final Color _color = Colors.black;

  @override
  void initState() {
    imageSize = initialImageSize;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialImageSize - scrollController.offset;

        containerHeight = containerInitialHeight - scrollController.offset;
        if (containerHeight < 0) {
          containerHeight = 0;
        }
        imageOpacity = imageSize / initialImageSize;
        if (scrollController.offset > 150) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }
        // print(imageSize);
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlaylists = [
      ...context.watch<DataProvider>().favoritePlaylists,
    ];
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 19,
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ProfileImage(
                                imageSize: initialImageSize,
                                image: widget.image,
                                imageOpacity: imageOpacity,
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
          Positioned(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color:
                  showTopBar ? _color.withOpacity(0.85) : _color.withOpacity(0),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              child: SafeArea(
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      const Positioned(
                        left: -5,
                        child: BackIconButton(),
                      ),
                      AnimateLabel(label: widget.label, isShow: showTopBar),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildListView(list) {
  //   return ListView.builder(
  //     itemCount: list.length,
  //     itemBuilder: (context, index) {
  //       final item = list[index];
  //
  //       return GestureDetector(
  //         child: ListItem(
  //           title: item.name,
  //           subtitle: item.runtimeType.toString(),
  //           coverUrl: item.coverImageUrl,
  //           isSquareCover: item.runtimeType.toString() != 'Artist',
  //         ),
  //         onTap: () {
  //           onTap(item);
  //         },
  //       );
  //     },
  //   );
  // }

  void onTap(item) {
    final ImageProvider image;

    if (item.coverImageUrl.startsWith('https')) {
      image = NetworkImage(item.coverImageUrl);
    } else {
      image = AssetImage(item.coverImageUrl);
    }

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
