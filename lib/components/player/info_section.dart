import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:spotify/components/player/favorite_button.dart';
import 'package:spotify/models/song.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    Key? key,
    required this.name,
    required this.description,
    required this.song,
  }) : super(key: key);

  final String name;

  final String description;

  final Song song;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.75,
              child: Marquee(
                animationDuration: const Duration(milliseconds: 2500),
                backDuration: const Duration(milliseconds: 2500),
                pauseDuration: const Duration(milliseconds: 1500),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Marquee(
                animationDuration: const Duration(milliseconds: 2500),
                backDuration: const Duration(milliseconds: 2500),
                pauseDuration: const Duration(milliseconds: 1500),
                child: Text(
                  description,
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ],
        ),
        FavoriteButton(size: 28, song: song),
      ],
    );
  }
}
