import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/data_provider.dart';

import '../../models/song.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.size,
    required this.song,
  }) : super(key: key);

  final double size;
  final Song song;

  @override
  Widget build(BuildContext context) {
    final isFavorite =
        context.watch<DataProvider>().favoriteSongs.contains(song);

    return GestureDetector(
      child: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        size: size,
        color: isFavorite ? Colors.green : Colors.white,
      ),
      onTap: () {
        context
            .read<DataProvider>()
            .addFavoriteSongs(songs: [song], updateDb: true);
      },
    );
  }
}
