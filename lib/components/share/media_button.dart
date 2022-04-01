import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaButton extends StatelessWidget {
  final String text;
  final String coverUrl;
  final void Function()? onTap;

  const MediaButton({
    Key? key,
    required this.text,
    required this.coverUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      onTap: onTap,
    );
  }
}
