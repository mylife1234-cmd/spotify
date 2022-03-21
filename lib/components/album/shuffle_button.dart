import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff2a2a2a),
      ),
      child: const Icon(
        CupertinoIcons.shuffle,
        color: Colors.green,
        size: 12,

      ),
    );
  }
}
