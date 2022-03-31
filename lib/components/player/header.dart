import 'package:flutter/material.dart';
import 'package:spotify/components/actions/action_button.dart';

import '../../models/song.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({Key? key, required this.onDismissed, required this.song}) : super(key: key);
  final Song song;
  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            ),
            onTap: onDismissed,
          ),
          const Text(
            'Playlist 1',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          ActionButton(song: song, size: 20)
        ],
      ),
    );
  }
}
