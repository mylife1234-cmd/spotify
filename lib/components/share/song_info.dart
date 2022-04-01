import 'package:flutter/material.dart';

import '../../models/song.dart';

class SongInfo extends StatelessWidget {
  final Song song;

  const SongInfo({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(song.coverUrl),
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
