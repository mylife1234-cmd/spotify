import 'package:flutter/material.dart';

class PLayButton extends StatelessWidget {
  const PLayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      onTap: (){

      },
    );
  }
}
