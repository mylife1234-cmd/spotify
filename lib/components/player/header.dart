import 'package:flutter/material.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({Key? key, required this.onDismissed}) : super(key: key);

  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 6,
        bottom: size.height / 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            ),
            onTap: onDismissed,
          ),
          const Text(
            'Playlist 1',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            child: const Icon(Icons.more_horiz),
          )
        ],
      ),
    );
  }
}
