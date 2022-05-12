import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/actions/action_button.dart';
import 'package:spotify/utils/helper.dart';

import '../../models/playlist.dart';
import '../../models/song.dart';
import '../../providers/music_provider.dart';

class SongTileUser extends StatelessWidget {
  const SongTileUser({
    Key? key,
    required this.song,
    required this.playlist,
    this.deleteSong,
  }) : super(key: key);
  final Song song;
  final Playlist playlist;
  final void Function()? deleteSong;
  @override
  Widget build(BuildContext context) {
    final currentSong = context.watch<MusicProvider>().currentSong;

    final isCurrent =
        (currentSong != null ? currentSong.name : '') == song.name;

    final image = getImageFromUrl(song.coverImageUrl);

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
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          song.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: Image(
          image: image,
          fit: BoxFit.cover,
        ),
        trailing: ActionButton(
          song: song,
          size: 20,
          // onPressed: () {
          //   Navigator.of(context, rootNavigator: true).push(
          //     MaterialPageRoute(
          //       builder: (context) => SongActionUser(
          //         song: song,
          //         playlist: playlist,
          //       ),
          //     ),
          //   );
          // },
          onPressed: deleteSong,
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 12,
      ),
    );
  }
}
