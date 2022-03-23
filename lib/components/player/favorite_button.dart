import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/music_provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    var isFavorite = context.watch<MusicProvider>().isFavorite;

    return GestureDetector(
      child: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        size: size,
        color: isFavorite ? Colors.green : Colors.white,
      ),
      onTap: () {
        context.read<MusicProvider>().toggleFavorite();
      },
    );
  }
}
