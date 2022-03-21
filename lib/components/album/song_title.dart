
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/album_view.dart';

import '../../models/song.dart';
import '../../providers/music_provider.dart';

class SongTitle extends StatelessWidget {
  const SongTitle({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    var _currentSong = context.watch<MusicProvider>().currentSong;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // color: Colors.black.withOpacity(0.5),
        color: Colors.black,

      ),
      child: ListTile(
        title: Text(
          song.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(song.description),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          // child: Image.asset(song.coverUrl),
          child: Image(image: AssetImage(song.coverUrl),
            // height: 70,
            // width: 50,
            fit: BoxFit.cover,
          ),
        ),
        trailing: GestureDetector(
          child: Icon(
            CupertinoIcons.ellipsis,
            size: 20,
          ),
          onTap: () {
          },
        ),
        contentPadding: EdgeInsets.zero,
        dense: false,
        horizontalTitleGap: 15,
        // visualDensity: VisualDensity.comfortable,
        minVerticalPadding: 12,
        onTap: () {
          context.read<MusicProvider>().playNewSong(song);
        },
      ),
    );
  }
}
