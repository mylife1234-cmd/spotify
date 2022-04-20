import 'package:flutter/cupertino.dart';
import 'package:spotify/components/player/backward_button.dart';
import 'package:spotify/components/player/forward_button.dart';
import 'package:spotify/components/player/play_button.dart';
import 'package:spotify/components/player/repeat_button.dart';
import 'package:spotify/components/player/shuffle_button.dart';

class ControllerSection extends StatelessWidget {
  const ControllerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        ShuffleButton(size: 20),
        BackwardButton(size: 30),
        PlayButton(
          playIcon: CupertinoIcons.play_circle_fill,
          pauseIcon: CupertinoIcons.pause_circle_fill,
          size: 70,
        ),
        ForwardButton(size: 30),
        RepeatButton(size: 20),
      ],
    );
  }
}
