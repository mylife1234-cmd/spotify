import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:spotify/components/player/favorite_button.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    Key? key,
    required this.name,
    required this.description,
  }) : super(key: key);

  final String name;

  final String description;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        const FavoriteButton(size: 28),
      ],
    );
  }
}
