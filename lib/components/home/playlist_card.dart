import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/playlist_view.dart';

import '../../providers/data_provider.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.id,
    required this.label,
    required this.image,
    this.songIdList,
  }) : super(key: key);

  final String id;
  final String label;
  final ImageProvider image;
  final List? songIdList;
  @override
  Widget build(BuildContext context) {
    final iscustomizedPlaylist = context
        .watch<DataProvider>()
        .user
        .customizedPlaylistIdList
        .contains(id);
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
            ),
          ),
        );
      },
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: image, width: 120, height: 120, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            if (iscustomizedPlaylist)
              Text(
                'Playlist ∙ user',
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            else
              Text(
                'Playlist ∙ system',
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
