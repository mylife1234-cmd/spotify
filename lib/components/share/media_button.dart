import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaButton extends StatelessWidget {
  final String text;
  final String coverUrl;
  const MediaButton({Key? key, required this.text, required this.coverUrl,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Image(image: AssetImage(coverUrl), width: 40, height: 40, fit: BoxFit.cover),

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
    );
  }
}
