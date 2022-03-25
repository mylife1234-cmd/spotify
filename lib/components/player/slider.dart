import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/music_provider.dart';

class MusicSlider extends StatefulWidget {
  const MusicSlider({Key? key}) : super(key: key);

  @override
  State<MusicSlider> createState() => _MusicSliderState();
}

class _MusicSliderState extends State<MusicSlider> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    super.dispose();
  }

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
