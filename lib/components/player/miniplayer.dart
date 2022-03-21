import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotify/pages/player.dart';

import '../../models/song.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xff2f2215)),
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
        trailing: GestureDetector(
          child: const Icon(
            Icons.play_arrow,
            size: 28,
          ),
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
        horizontalTitleGap: 12,
        visualDensity: VisualDensity.compact,
        minVerticalPadding: 12,
        onTap: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) {
              return MusicPlayer(song: song);
            },
            duration: const Duration(milliseconds: 250),
          );
        },
      ),
    );
  }
}
