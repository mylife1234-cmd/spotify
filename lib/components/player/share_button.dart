import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../models/song.dart';
import '../../pages/share_page.dart';

class ShareButton extends StatelessWidget {
  final Song song;

  // Color color = Colors.black;
  final double size;

  const ShareButton({
    Key? key,
    required this.song,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    PaletteGenerator.fromImageProvider(AssetImage(song.coverUrl))
        .then((generator) {
      color = generator.mutedColor!.color.withOpacity(1);
    });
    return GestureDetector(
      child: Icon(
        Icons.ios_share,
        size: size,
      ),
      onTap: () async {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
          SystemUiOverlay.top,
        ]);

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SharePage(
              color: color,
              song: song,
            ),
          ),
        );

        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      },
    );
  }
}
