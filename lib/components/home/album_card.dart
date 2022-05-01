import 'package:flutter/material.dart';
import 'package:spotify/pages/album_view.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key? key,
    required this.label,
    required this.image,
    this.songIdList,
    required this.description,
    required this.id,
  }) : super(key: key);

  final String label;
  final ImageProvider image;
  final List? songIdList;
  final String description;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumView(
              id: id,
              image: image,
              label: label,
              songIdList: songIdList,
              description: description,
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
              maxLines: 1,
            ),
            const Icon(
              Icons.circle,
              size: 7,
              color: Colors.black,
            ),
            const Text(
              "Album ",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
