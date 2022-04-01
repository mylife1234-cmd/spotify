import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/music_provider.dart';

class MusicSlider extends StatelessWidget {
  const MusicSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var progress = context.watch<MusicProvider>().progressState;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ProgressBar(
        progress: progress.current,
        total: progress.total,
        barHeight: 4,
        baseBarColor: Colors.white30,
        progressBarColor: Colors.white,
        thumbColor: Colors.white,
        thumbGlowColor: Colors.white,
        thumbRadius: 6,
        thumbGlowRadius: 8,
        onSeek: context.read<MusicProvider>().seek,
      ),
    );
  }
}
