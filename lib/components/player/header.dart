import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/actions/action_button.dart';
import 'package:spotify/providers/music_provider.dart';

import '../../models/song.dart';
import '../../pages/music/song_action.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({Key? key, required this.onDismissed, required this.song})
      : super(key: key);
  final Song song;
  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    final name = context.watch<MusicProvider>().currentPlaylistName;

    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 30,
            child: GestureDetector(
              onTap: onDismissed,
              child: const Icon(
                Icons.keyboard_arrow_down,
                size: 30,
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 30,
            child: ActionButton(
              song: song,
              size: 20,
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongAction(
                      song: song,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
