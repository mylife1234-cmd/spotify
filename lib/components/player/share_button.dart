import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../pages/share_page.dart';

class ShareButton extends StatelessWidget {
  final Song song;
  final Color color;
  final double size;
  const ShareButton({Key? key, required this.song, required this.color, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:  Icon(
        Icons.ios_share,
        size: size,
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SharePage(
                color: color,
                song: song,
              ),
            ));
      },
    );
  }
}
