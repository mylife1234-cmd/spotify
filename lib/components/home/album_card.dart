import 'package:flutter/material.dart';
import 'package:spotify/models/album.dart';
import 'package:spotify/pages/music/album/album_view.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key? key,
    required this.album,
    required this.image,
    required this.description,
    required this.size,
  }) : super(key: key);

  final Album album;
  final ImageProvider image;
  final String description;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumView(
              album: album,
              image: image,
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
              album.name,
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
