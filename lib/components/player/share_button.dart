import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../pages/music/share_page.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    required this.song,
    required this.size,
  }) : super(key: key);

  final Song song;

  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.ios_share,
        size: size,
      ),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SharePage(
              song: song,
            ),
          ),
        );
      },
    );
  }
}
