import 'package:flutter/material.dart';
import 'package:spotify/models/playlist.dart';
import 'package:spotify/pages/music/playlist/playlist_view.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.playlist,
    required this.image,
    required this.size,
  }) : super(key: key);

  final Playlist playlist;
  final ImageProvider image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlaylistView(playlist: playlist, image: image);
            },
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
              playlist.name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            if (playlist.type == 'user')
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
