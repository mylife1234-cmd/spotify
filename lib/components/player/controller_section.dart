import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:spotify/components/player/play_button.dart';

class ControllerSection extends StatefulWidget {
  const ControllerSection({Key? key}) : super(key: key);

  @override
  State<ControllerSection> createState() => _ControllerSectionState();
}

class _ControllerSectionState extends State<ControllerSection> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(
          CupertinoIcons.shuffle,
          size: 20,
        ),
        Icon(
          CupertinoIcons.backward_end_fill,
          size: 30,
        ),
        PlayButton(
          playIcon: CupertinoIcons.play_circle_fill,
          pauseIcon: CupertinoIcons.pause_circle_fill,
          size: 70,
        ),
        Icon(
          CupertinoIcons.forward_end_fill,
          size: 30,
        ),
        Icon(
          CupertinoIcons.repeat,
          size: 20,
        )
      ],
    );
  }
}
