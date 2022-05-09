import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/song.dart';
import '../../providers/data_provider.dart';
import '../../providers/music_provider.dart';
import '../../utils/helper.dart';

class SongSearch extends StatelessWidget {
  const SongSearch({
    Key? key,
    required this.song,
    required this.trailing,
  }) : super(key: key);

  final Song song;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final image = getImageFromUrl(song.coverImageUrl);

    final String description = song.description;

    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: ListTile(
        title: Text(
          song.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: trailing,
        subtitle: Text(
          'Song ∙ $description',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image(image: image, fit: BoxFit.cover),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        onTap: () async {
          final currentPlaylistId =
              Provider.of<MusicProvider>(context, listen: false)
                  .currentPlaylistId;

          if (currentPlaylistId != song.id) {
            if (song.audioUrl == '') {
              song.audioUrl =
                  await getFileFromFirebase('/song/audio/${song.id}.mp3');
            }

            await context.read<MusicProvider>().loadPlaylist([song]);

            context
                .read<MusicProvider>()
                .updateCurrentPlaylist(song.id, 'Song');
          }
          context.read<DataProvider>().addToRecentSearchList(song);
          context.read<MusicProvider>().playNewSong(song);
        },
      ),
    );
  }
}
