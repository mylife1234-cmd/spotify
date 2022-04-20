import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/music_provider.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
    required this.playIcon,
    required this.pauseIcon,
    required this.size,
  }) : super(key: key);

  final IconData playIcon;

  final IconData pauseIcon;

  final double size;

  @override
  Widget build(BuildContext context) {
    final playing = context.watch<MusicProvider>().playing;

    return GestureDetector(
      child: Icon(!playing ? playIcon : pauseIcon, size: size),
      onTap: () {
        if (playing) {
          context.read<MusicProvider>().pause();
        } else {
          context.read<MusicProvider>().play();
        }
      },
    );
  }
}
