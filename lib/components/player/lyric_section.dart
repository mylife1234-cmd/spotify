import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/music_provider.dart';

class LyricSection extends StatelessWidget {
  const LyricSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lyric = context.watch<MusicProvider>().lyric;

    final color = context.watch<MusicProvider>().color;

    if (lyric.isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: Text(
              'LYRICS',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
          Text(
            lyric,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
