import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  final String label;
  final AssetImage image;

  const SongCard({
    Key? key,
    required this.label,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: image, width: 120, height: 120, fit: BoxFit.cover),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
