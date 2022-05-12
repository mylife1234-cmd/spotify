import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/album.dart';
import '../../pages/music/album/album_action.dart';
import '../../providers/data_provider.dart';

class AlbumComponent extends StatelessWidget {
  const AlbumComponent({
    Key? key,
    this.onTap,
    required this.album,
  }) : super(key: key);

  final Album album;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final favoriteAlbums = context.watch<DataProvider>().favoriteAlbums;

    final isFavorite = favoriteAlbums.any((element) => element.id == album.id);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20, top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            album.name,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Image(
                image: AssetImage('assets/images/logo_spotify.png'),
                width: 20,
                height: 20,
              ),
              SizedBox(width: 7),
              Text('Spotify',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          album.description,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(height: 10),
        Row(
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
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) => AlbumAction(
                      album: album,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.more_horiz,
                size: 22,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
