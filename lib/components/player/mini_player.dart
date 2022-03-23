import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/player.dart';
import 'package:spotify/providers/music_provider.dart';

import '../../models/song.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    var playing = context.watch<MusicProvider>().playing;

    var color = context.watch<MusicProvider>().color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: ListTile(
        title: Text(
          song.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(song.description),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(song.coverUrl),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite_outline_rounded, size: 23),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 5, left: 10),
                child: Icon(
                  !playing ? Icons.play_arrow : Icons.pause,
                  size: 28,
                ),
              ),
              onTap: () {
                if (playing) {
                  context.read<MusicProvider>().pause();
                } else {
                  context.read<MusicProvider>().play();
                }
              },
            ),
          ],
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
        horizontalTitleGap: 12,
        visualDensity: VisualDensity.comfortable,
        minVerticalPadding: 12,
        onTap: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) {
              return MusicPlayer(song: song, color: color);
            },
            duration: const Duration(milliseconds: 250),
          );
        },
      ),
    );
  }
}
