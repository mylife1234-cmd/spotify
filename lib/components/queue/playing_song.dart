import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/song.dart';
import '../../providers/music_provider.dart';

class PlayingSongTile extends StatelessWidget {
  const PlayingSongTile({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    var playing = context.watch<MusicProvider>().playing;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.black,
      child: ListTile(
        title: Text(
          song.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700 ,
            color: Colors.green,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(song.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(song.coverUrl),
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 12,
        onTap: () {
          if (playing) {
            context.read<MusicProvider>().pause();
          } else {
            context.read<MusicProvider>().play();
          }
        },
      ),
    );
  }
}
