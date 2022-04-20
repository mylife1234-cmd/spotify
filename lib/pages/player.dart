import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/player/controller_section.dart';
import 'package:spotify/components/player/header.dart';
import 'package:spotify/components/player/info_section.dart';
import 'package:spotify/components/player/queue_button.dart';
import 'package:spotify/components/player/slider.dart';

import '../components/player/share_button.dart';
import '../providers/music_provider.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.watch<MusicProvider>().color.withOpacity(0.7);

    final song = context.watch<MusicProvider>().currentSong;

    final size = MediaQuery.of(context).size;

    final padding = size.height / 33;

    return Scaffold(
      backgroundColor: color,
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(top: padding),
            child: PlayerHeader(
              onDismissed: () {
                Navigator.maybePop(context);
              },
              song: song!,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 24, vertical: padding * 0.8),
            child: Image.asset(song.coverUrl),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: InfoSection(name: song.name, description: song.description),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 18, right: 18, top: padding * 0.6, bottom: padding * 0.2),
            child: const MusicSlider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
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
                QueueButton(song: song, size: 26),
              ],
            ),
          )
        ],
      ),
    );
  }
}
