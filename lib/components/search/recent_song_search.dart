import 'package:flutter/material.dart';
import '../../models/song.dart';
import '../../utils/helper.dart';

class RecentSongSearch extends StatelessWidget {
  const RecentSongSearch(
      {Key? key, required this.song, required this.id, this.onPressed})
      : super(key: key);
  final Song song;
  final String id;
  final void Function()? onPressed;
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
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.close),
        ),
        subtitle: Text(
          'Song ∙ $description',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: Image(image: image),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
