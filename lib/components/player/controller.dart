import 'package:flutter/cupertino.dart';

class MusicController extends StatefulWidget {
  const MusicController({Key? key}) : super(key: key);

  @override
  State<MusicController> createState() => _MusicControllerState();
}

class _MusicControllerState extends State<MusicController> {
  bool _playing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          CupertinoIcons.shuffle,
          size: 20,
        ),
        const Icon(
          CupertinoIcons.backward_end_fill,
          size: 30,
        ),
        GestureDetector(
          child: Icon(
            _playing
                ? CupertinoIcons.play_circle_fill
                : CupertinoIcons.pause_circle_fill,
            size: 70,
          ),
          onTap: () => setState(() {
            _playing = !_playing;
          }),
        ),
        const Icon(
          CupertinoIcons.forward_end_fill,
          size: 30,
        ),
        const Icon(
          CupertinoIcons.repeat,
          size: 20,
        )
      ],
    );
  }
}
