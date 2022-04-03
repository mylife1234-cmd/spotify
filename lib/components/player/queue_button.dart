import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify/pages/playlist_queue.dart';

import '../../models/song.dart';

class QueueButton extends StatelessWidget {
  final Song song;

  // Color color = Colors.black;
  final double size;

  const QueueButton({
    Key? key,
    required this.song,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.playlist_play_rounded,
        size: size,
      ),
      onTap: () async {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
          SystemUiOverlay.top,
        ]);

        await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) {
              return PlaylistQueue(song: song);
            },
            transitionsBuilder: (context, a1, a2, child) {
              return FadeTransition(opacity: a1, child: child);
            },
            transitionDuration: const Duration(milliseconds: 150),
            reverseTransitionDuration: const Duration(milliseconds: 150),
          ),
        );

        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      },
    );
  }
}
