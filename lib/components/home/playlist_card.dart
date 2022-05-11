import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/music/playlist_view.dart';

import '../../providers/data_provider.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.id,
    required this.label,
    required this.image,
    this.songIdList,
    required this.size,
    required this.type,
  }) : super(key: key);

  final String id;
  final String label;
  final ImageProvider image;
  final List? songIdList;
  final double size;
  final String type;
  @override
  Widget build(BuildContext context) {
    final customizedPlaylist = context
        .watch<DataProvider>()
        .customizedPlaylists
        .any((element) => element.id == id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistView(
              id: id,
              image: image,
              label: label,
              songIdList: songIdList,
              type: type,
            ),
          ),
        );
      },
      child: SizedBox(
        width: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: image, width: size, height: size, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            if (customizedPlaylist)
              Text(
                'Playlist ∙ User',
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            else
              Text(
                'Playlist ∙ System',
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
          ],
        ),
      ),
    );
  }
}
