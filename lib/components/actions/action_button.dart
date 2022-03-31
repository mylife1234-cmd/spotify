import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/pages/song_action.dart';

import '../../models/song.dart';

class ActionButton extends StatelessWidget {
  final Song song;
  Color color = Colors.black;
  final double size;


  ActionButton({Key? key, required this.song, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaletteGenerator.fromImageProvider(AssetImage(song.coverUrl))
        .then((generator) {
      color = generator.mutedColor!.color.withOpacity(1);
    });
    return IconButton(
    icon:  Icon(
      // Icons.more_horiz,
      CupertinoIcons.ellipsis,
      size: size,
    ),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongAction(
              color: color,
              song: song,
            ),
          ));
    },
  );return Container();
  }
}
