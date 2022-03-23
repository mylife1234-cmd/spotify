import 'package:flutter/material.dart';
import 'package:spotify/components/player/controller_section.dart';
import 'package:spotify/components/player/header.dart';
import 'package:spotify/components/player/info_section.dart';
import 'package:spotify/components/player/slider.dart';
import 'package:spotify/models/song.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    Key? key,
    required this.song,
    required this.color,
  }) : super(key: key);

  final Song song;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          PlayerHeader(
            onDismissed: () {
              Navigator.maybePop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Image.asset(song.coverUrl),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: InfoSection(name: song.name, description: song.description),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: MusicSlider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: ControllerSection(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.ios_share,
                  size: 22,
                ),
                Icon(
                  Icons.playlist_play_rounded,
                  size: 26,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
