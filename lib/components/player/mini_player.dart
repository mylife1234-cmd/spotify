import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/player/favorite_button.dart';
import 'package:spotify/components/player/play_button.dart';
import 'package:spotify/pages/music/player.dart';
import 'package:spotify/providers/music_provider.dart';

import '../../models/song.dart';
import '../../utils/helper.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    final color = context.watch<MusicProvider>().color.withOpacity(0.7);

    final image = getImageFromUrl(song.coverImageUrl);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: ListTile(
        title: Marquee(
          animationDuration: const Duration(milliseconds: 1500),
          backDuration: const Duration(milliseconds: 1500),
          pauseDuration: const Duration(milliseconds: 1500),
          child: Text(
            song.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        subtitle: Marquee(
          animationDuration: const Duration(milliseconds: 1500),
          backDuration: const Duration(milliseconds: 1500),
          pauseDuration: const Duration(milliseconds: 1500),
          child: Text(song.description),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image(image: image),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FavoriteButton(size: 23, song: song),
            const Padding(
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
          await SystemChrome.setEnabledSystemUIMode(
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

          await SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: [
              SystemUiOverlay.top,
              SystemUiOverlay.bottom,
            ],
          );
        },
      ),
    );
  }
}
