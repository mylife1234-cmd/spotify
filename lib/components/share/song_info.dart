import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../utils/calculation/helper.dart';

class SongInfo extends StatelessWidget {
  const SongInfo({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    final image = getImageFromUrl(song.coverImageUrl);

    return Column(
      children: [
        Image(
          image: image,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        Container(
          width: 180,
          padding: const EdgeInsets.only(top: 25),
          child: Text(
            song.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                letterSpacing: 0.2, fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 30),
          child: Text(
            song.description,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
