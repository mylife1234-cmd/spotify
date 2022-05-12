import 'package:flutter/cupertino.dart';

import '../../models/song.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.song,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  final Song song;

  final double size;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        CupertinoIcons.ellipsis,
        size: size,
      ),
    );
  }
}
