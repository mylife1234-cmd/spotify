import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_firebase/flutter_cache_manager_firebase.dart';
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
      image: CachedNetworkImageProvider(url),
    ).image;
  } else {
    return AssetImage(url);
  }
}

Future<String> getFileFromFirebase(String ref) async {
  if (ref.endsWith('.mp3')) {
    final file = await FirebaseCacheManager().getSingleFile(ref);

    return file.path;
  }

  return FirebaseStorage.instance.ref(ref).getDownloadURL();
}
