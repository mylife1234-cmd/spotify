import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../utils/helper.dart';

class PlayingSongTile extends StatelessWidget {
  const PlayingSongTile({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    final image = getImageFromUrl(song.coverImageUrl);

    return Container(
      color: Colors.black,
      child: ListTile(
        title: Text(
          song.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.green,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          song.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: Image(image: image),
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 12,
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
