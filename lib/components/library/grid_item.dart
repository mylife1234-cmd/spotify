import 'package:flutter/material.dart';

import '../../utils/calculation/helper.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.coverUrl,
    required this.isSquareCover,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String coverUrl;
  final bool isSquareCover;

  @override
  Widget build(BuildContext context) {
    final image = getImageFromUrl(coverUrl);

    return Column(
      crossAxisAlignment:
          isSquareCover ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(isSquareCover ? 0 : 100),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white60,
          ),
        )
      ],
    );
  }
}
