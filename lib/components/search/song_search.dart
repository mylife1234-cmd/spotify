import 'package:flutter/material.dart';

import '../../models/song.dart';
import '../../pages/song_action.dart';
import '../../utils/helper.dart';
import '../actions/action_button.dart';

class SongSearch extends StatelessWidget {
  const SongSearch({Key? key, required this.song}) : super(key: key);
  final Song song;

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
        trailing: ActionButton(
          song: song,
          size: 20,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => SongAction(song: song),
              ),
            );
          },
        ),
        subtitle: Text('Song ∙ $description'),
        leading: Image(image: image),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
