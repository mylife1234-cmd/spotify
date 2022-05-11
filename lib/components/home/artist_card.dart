import 'package:flutter/material.dart';

import '../../pages/music/artist_view.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
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
            builder: (context) => ArtistView(
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
                label,
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
