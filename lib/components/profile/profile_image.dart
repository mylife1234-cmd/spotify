import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.imageOpacity,
    required this.imageSize,
    required this.image,
  }) : super(key: key);

  final double imageOpacity;
  final double imageSize;
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: imageOpacity.clamp(0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0),
              offset: const Offset(0, 10),
              blurRadius: 20,
              spreadRadius: 10,
            )
          ],
        ),
        child: CircleAvatar(backgroundImage: image, radius: imageSize / 3),
      ),
    );
  }
}
