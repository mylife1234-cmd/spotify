import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/artist.dart';
import '../../pages/music/artist/artist_action.dart';
import '../../providers/data_provider.dart';

class ArtistComponent extends StatelessWidget {
  const ArtistComponent({
    Key? key,
    this.onTap,
    required this.artist,
  }) : super(key: key);

  final Artist artist;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context
        .watch<DataProvider>()
        .favoriteArtists
        .any((element) => element.id == artist.id);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 13, right: 25, top: 20, bottom: 10),
          child: Text(
            artist.name,
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 20, top: 10),
        child: Text(
          artist.description,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 20, top: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                size: 22,
                color: isFavorite ? Colors.green : Colors.white,
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtistAction(artist: artist),
                  ),
                );
              },
              child: const Icon(
                Icons.more_horiz,
                size: 22,
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
