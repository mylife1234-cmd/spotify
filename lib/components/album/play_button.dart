import 'package:flutter/material.dart';

class PLayButton extends StatelessWidget {
  const PLayButton({Key? key, required this.onTap}) : super(key: key);

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: const Icon(
          Icons.play_arrow,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}
