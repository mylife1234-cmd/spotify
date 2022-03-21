import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/music_provider.dart';

import '../../models/song.dart';

class SongCard extends StatelessWidget {
  const SongCard({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MusicProvider>().playNewSong(song);
      },
      child: Container(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(song.coverUrl),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            Text(
              song.name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
