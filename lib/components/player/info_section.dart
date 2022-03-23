import 'package:flutter/material.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                description,
                style: const TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
        const FavoriteButton(size: 28),
      ],
    );
  }
}
