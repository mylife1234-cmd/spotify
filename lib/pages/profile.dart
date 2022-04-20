import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/components/album/animate_label.dart';
import 'package:spotify/components/album/song_tile.dart';
import 'package:spotify/components/artist/back_button.dart';
import 'package:spotify/components/profile/profile_component.dart';
import 'package:spotify/components/profile/profile_image.dart';

import '../models/song.dart';
import '../providers/music_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.image, required this.label})
      : super(key: key);

  final AssetImage image;
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

  Color _color = Colors.black;

  @override
  void initState() {
    imageSize = initialImageSize;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialImageSize - scrollController.offset;
        if (imageSize < 0) {
          imageSize = 0;
        }
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
    PaletteGenerator.fromImageProvider(widget.image).then((generator) {
      setState(() {
        _color = generator.mutedColor!.color;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _color.withOpacity(1),
                  _color.withOpacity(0.7),
                  _color.withOpacity(0.5),
                  _color.withOpacity(0.3),
                  // Colors.black.withOpacity(0.1),
                  // Colors.transparent,
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(1),
                ],
              ),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 19,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: ProfileImage(
                      imageOpacity: imageOpacity,
                      imageSize: imageSize,
                      image: widget.image,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _color.withOpacity(0),
                          _color.withOpacity(0),
                          _color.withOpacity(0),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 150),
                          ProfileComponent(label: widget.label),
                        ],
                      ),
                    ),
                  ),
                  _buildListSong(),
                ],
              ),
            ),
          ),
          Positioned(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: showTopBar ? _color.withOpacity(1) : _color.withOpacity(0),
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
}

Widget _buildListSong() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: songList.map((item) {
      return SongTile(
        song: Song(item['title']!, item['desc']!, item['coverUrl']!),
      );
    }).toList(),
  );
}
