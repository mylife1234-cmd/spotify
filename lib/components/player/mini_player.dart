import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/player/favorite_button.dart';
import 'package:spotify/components/player/play_button.dart';
import 'package:spotify/pages/player.dart';
import 'package:spotify/providers/music_provider.dart';

import '../../models/song.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    var color = context.watch<MusicProvider>().color.withOpacity(0.7);

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
          children: const [
            FavoriteButton(size: 23),
            Padding(
              padding: EdgeInsets.only(right: 5, left: 10),
              child: PlayButton(
                playIcon: Icons.play_arrow,
                pauseIcon: Icons.pause,
                size: 28,
              ),
            ),
          ],
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
        horizontalTitleGap: 12,
        visualDensity: VisualDensity.compact,
        minVerticalPadding: 12,
        onTap: () async {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: [],
          );

          await showMaterialModalBottomSheet(
            context: context,
            builder: (context) {
              return const MusicPlayer();
            },
            duration: const Duration(milliseconds: 250),
          );

          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
            SystemUiOverlay.top,
            SystemUiOverlay.bottom,
          ]);
        },
      ),
    );
  }
}
