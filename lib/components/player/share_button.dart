import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/song.dart';
import '../../pages/share_page.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    required this.song,
    required this.size,
  }) : super(key: key);

  final Song song;

  // Color color = Colors.black;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.ios_share,
        size: size,
      ),
      onTap: () async {
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [
              SystemUiOverlay.top,
            ]);

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SharePage(
              song: song,
            ),
          ),
        );

        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: []);
      },
    );
  }
}
