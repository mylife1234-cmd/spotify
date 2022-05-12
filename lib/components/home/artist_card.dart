import 'package:flutter/material.dart';
import 'package:spotify/models/artist.dart';

import '../../pages/music/artist/artist_view.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    Key? key,
    required this.artist,
    required this.image,
    required this.size,
  }) : super(key: key);

  final Artist artist;
  final ImageProvider image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtistView(artist: artist, image: image),
          ),
        );
      },
      child: SizedBox(
        // width: 120,
        width: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                image: DecorationImage(image: image, fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 9),
            Center(
              child: Text(
                artist.name,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                'Artist',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
