import 'package:flutter/material.dart';

class OpacityImage extends StatelessWidget {
  const OpacityImage({
    Key? key,
    required this.imageOpacity,
    required this.imageSize,
    required this.image,
  }) : super(key: key);

  final double imageOpacity;
  final double imageSize;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: imageOpacity.clamp(0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.6),
              offset: const Offset(0, 10),
              blurRadius: 20,
              spreadRadius: 10,
            )
          ],
        ),
        child: Image(
          // image: widget.image,
          image: image,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
