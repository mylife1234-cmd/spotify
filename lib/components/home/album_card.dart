import 'package:flutter/material.dart';
import 'package:spotify/pages/music/album_view.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key? key,
    required this.label,
    required this.image,
    this.songIdList,
    required this.description,
    required this.id,
    required this.size,
  }) : super(key: key);

  final String label;
  final ImageProvider image;
  final List? songIdList;
  final String description;
  final String id;
  final double size;
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
        width: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: image, width: size, height: size, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            Text(
              'Album ∙ $description',
              style: Theme.of(context).textTheme.caption,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
