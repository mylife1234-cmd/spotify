import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_provider.dart';

class AlbumComponent extends StatelessWidget {
  const AlbumComponent({
    Key? key,
    required this.label,
    this.description,
    required this.id,
    this.onTap,
  }) : super(key: key);

  final String label;
  final String? description;
  final String id;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context
            .watch<DataProvider>()
            .user
            .favoriteAlbumIdList
            .contains(id) ||
        context.watch<DataProvider>().user.favoritePlaylistIdList.contains(id);
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
        const SizedBox(height: 12),
        if (description != null)
          Text(
            description!,
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
            const Icon(
              Icons.more_horiz,
              size: 22,
            ),
          ],
        )
      ]),
    );
  }
}
