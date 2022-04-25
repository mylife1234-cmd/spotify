import 'package:flutter/material.dart';
import 'package:spotify/pages/playlist_view.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.id,
    required this.label,
    required this.image,
    this.songIdList,
  }) : super(key: key);

  final String id;
  final String label;
  final ImageProvider image;
  final List? songIdList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistView(
              image: image,
              label: label,
              songIdList: songIdList,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: image, width: 120, height: 120, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
