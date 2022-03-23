import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/music_provider.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    var repeatMode = context.watch<MusicProvider>().repeatMode;

    return GestureDetector(
      child: Icon(
        repeatMode == RepeatMode.one
            ? CupertinoIcons.repeat_1
            : CupertinoIcons.repeat,
        size: size,
        color: (repeatMode == RepeatMode.off)
            ? Colors.white
            : Colors.green,
      ),
      onTap: () {
        context.read<MusicProvider>().toggleRepeatMode();
      },
    );
  }
}
