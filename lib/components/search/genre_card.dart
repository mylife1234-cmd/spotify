import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    Key? key,
    required this.title,
    required this.image,
    required this.colors,
  }) : super(key: key);

  final String title;
  final ImageProvider image;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0.8, 0),
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 15,
              left: 15,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width / 4.5),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: -20,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(25 / 360),
                child: Image(image: image, height: 80, width: 80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
