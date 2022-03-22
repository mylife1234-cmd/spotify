import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/song.dart';
import '../../providers/music_provider.dart';

class SongTile extends StatelessWidget {
  const SongTile({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.black,
      child: ListTile(
        title: Text(
          song.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(song.description),
        leading: Image(
          image: AssetImage(song.coverUrl),
          fit: BoxFit.cover,
        ),
        trailing: GestureDetector(
          child: const Icon(
            CupertinoIcons.ellipsis,
            size: 20,
          ),
          onTap: () {},
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 12,
        onTap: () {
          context.read<MusicProvider>().playNewSong(song);
        },
      ),
    );
  }
}
