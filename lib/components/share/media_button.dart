import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaButton extends StatelessWidget {
  const MediaButton({
    Key? key,
    required this.text,
    required this.coverUrl,
    this.onTap,
  }) : super(key: key);

  final String text;
  final String coverUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image(
            image: AssetImage(coverUrl),
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
