import 'package:flutter/material.dart';

import '../../utils/helper.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key? key, required this.item}) : super(key: key);

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    final image = getImageFromUrl(item.coverImageUrl);

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
            item.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                letterSpacing: 0.2, fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Text(
            item.runtimeType.toString() == 'Playlist'
                ? 'Playlist'
                : item.description,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
