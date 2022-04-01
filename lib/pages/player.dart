import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/player/controller_section.dart';
import 'package:spotify/components/player/header.dart';
import 'package:spotify/components/player/info_section.dart';
import 'package:spotify/components/player/slider.dart';

import '../components/player/share_button.dart';
import '../providers/music_provider.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = context.watch<MusicProvider>().color.withOpacity(0.7);

    var song = context.watch<MusicProvider>().currentSong;

    return Scaffold(
      backgroundColor: color,
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: PlayerHeader(
              onDismissed: () {
                Navigator.maybePop(context);
              },
              song: song!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Image.asset(song.coverUrl),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: InfoSection(name: song.name, description: song.description),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: MusicSlider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 0),
            child: ControllerSection(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 22,
              bottom: 12,
              top: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShareButton(song: song, size: 22),
                const Icon(
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
