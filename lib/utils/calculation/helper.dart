import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color?> getColorFromImage(ImageProvider imageProvider) async {
  final generator = await PaletteGenerator.fromImageProvider(imageProvider);

  if (generator.dominantColor != null) {
    final color = generator.dominantColor!.color;

    final luminance = color.computeLuminance();

    if (luminance >= 0.6) {
      return HSLColor.fromColor(color).withLightness(0.4).toColor();
    } else if (luminance <= 0.1) {
      return color;
    } else {
      return color.withOpacity(0.3);
    }
  } else {
    return null;
  }
}

ImageProvider getImageFromUrl(String url) {
  if (url.startsWith('https') || url.startsWith('http')) {
    return FadeInImage(
      placeholder: const AssetImage('assets/images/placeholder.png'),
      image: NetworkImage(url),
    ).image;
  } else {
    return AssetImage(url);
  }
}
