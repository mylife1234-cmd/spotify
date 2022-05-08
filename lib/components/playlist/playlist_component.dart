import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';

class PlaylistComponent extends StatelessWidget {
  const PlaylistComponent({
    Key? key,
    required this.label,
    required this.id,
    this.onTap,
  }) : super(key: key);

  final String label;
  final String id;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final favoritePlaylistList =
        context.watch<DataProvider>().favoritePlaylists;

    final isLikedSongsPlayLists = context.watch<DataProvider>().user.id == id;

    final isFavorite = favoritePlaylistList.any((element) => element.id == id);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20, top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            label,
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
        const SizedBox(height: 22),
        Row(
          children: [
            if (isLikedSongsPlayLists == false)
              GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    size: 22,
                    color: isFavorite ? Colors.green : Colors.white,
                  ),
                ),
              ),
            const Icon(Icons.more_horiz, size: 22),
          ],
        )
      ]),
    );
  }
}
