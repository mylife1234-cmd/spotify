import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/pages/song_action.dart';
import 'package:spotify/pages/profile.dart';
import '../../models/song.dart';

class ProfileButton extends StatelessWidget {
  final Song song;

  // Color color = Colors.black;
  final double size;

  const ProfileButton({
    Key? key,
    required this.song,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_forward_ios,
        size: size,
      ),
      onPressed: () async {
        // var color = Colors.black;
        // PaletteGenerator.fromImageProvider(AssetImage(song.coverUrl))
        //     .then((generator) {
        //   color = generator.mutedColor!.color;
        // });
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
          SystemUiOverlay.top,
        ]);

        await Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            //return const SearchPlayList();
            return  ProfilePage();
          }),
        );

        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      },
    );
  }
}
