import 'package:flutter/material.dart';
import 'package:spotify/components/player/controller.dart';
import 'package:spotify/components/player/header.dart';
import 'package:spotify/components/player/slider.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2f2215),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          PlayerHeader(
            onDismissed: () {
              Navigator.maybePop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Image.asset('assets/images/cam-on.jpg'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Cảm ơn',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Text(
              'Đen, Biên',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: MusicSlider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: MusicController(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.ios_share,
                  size: 22,
                ),
                Icon(
                  Icons.playlist_play_rounded,
                  size: 26,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
