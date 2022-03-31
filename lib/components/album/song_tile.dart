import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/actions/action_button.dart';

import '../../models/song.dart';
import '../../providers/music_provider.dart';

class SongTile extends StatelessWidget {
  const SongTile({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    var currentSong = context.watch<MusicProvider>().currentSong;

    final isCurrent = currentSong!.name == song.name;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.black,
      child: ListTile(
        title: Text(
          song.name,
          style: TextStyle(
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
            color: isCurrent ? Colors.green : Colors.white,
          ),
        ),
        subtitle: Text(song.description),
        leading: Image(
          image: AssetImage(song.coverUrl),
          fit: BoxFit.cover,
        ),
        trailing: ActionButton(song: song, size: 20),
      //   trailing:   const Icon(
      //   // Icons.more_horiz,
      //   CupertinoIcons.ellipsis,
      //   size: 20,
      // ),
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
