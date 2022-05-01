import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/song.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.song,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  final Song song;

  final double size;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.ellipsis,
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}
