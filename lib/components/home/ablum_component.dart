
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumComponent extends StatelessWidget {
  final String label;
  const AlbumComponent({Key? key, required this.label}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20, right: 20, top: 20, bottom: 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                label,
                style:
                Theme.of(context).textTheme.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Image(
                    image: AssetImage(
                        "assets/images/logo_spotify.png"),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 7),
                  Text("Spotify",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "1,999,890 likes 9h 56m",
              style:
              Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(
                  Icons.favorite_outline_rounded,
                  size: 22,
                ),
                SizedBox(width: 15),
                Icon(
                  CupertinoIcons.arrow_down_circle,
                  size: 22,
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.more_horiz,
                  size: 22,
                ),
              ],
            )
          ]),
    );
  }
}
