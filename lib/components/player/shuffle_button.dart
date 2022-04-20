import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/music_provider.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    final shuffling = context.watch<MusicProvider>().shuffling;

    return GestureDetector(
      child: Icon(
        CupertinoIcons.shuffle,
        size: size,
        color: shuffling ? Colors.green : Colors.white,
      ),
      onTap: () {
        context.read<MusicProvider>().toggleShuffle();
      },
    );
  }
}
