import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/music_provider.dart';

class BackwardButton extends StatelessWidget {
  const BackwardButton({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(CupertinoIcons.backward_end_fill, size: size),
      onTap: () {
        context.read<MusicProvider>().skipToPrevious();
      },
    );
  }
}
