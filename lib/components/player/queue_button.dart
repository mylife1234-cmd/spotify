import 'package:flutter/material.dart';
import 'package:spotify/pages/music/playlist_queue.dart';

import '../../models/song.dart';

class QueueButton extends StatelessWidget {
  const QueueButton({
    Key? key,
    required this.song,
    required this.size,
  }) : super(key: key);

  final Song song;

  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.playlist_play_rounded,
        size: size,
      ),
      onTap: () async {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) {
              return const PlaylistQueue();
            },
            transitionsBuilder: (context, a1, a2, child) {
              return FadeTransition(opacity: a1, child: child);
            },
            transitionDuration: const Duration(milliseconds: 150),
            reverseTransitionDuration: const Duration(milliseconds: 150),
          ),
        );
      },
    );
  }
}
