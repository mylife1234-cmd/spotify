import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/song.dart';
import '../../pages/album_view.dart';
import '../../pages/artist_view.dart';
import '../../pages/share_page.dart';
import '../../providers/music_provider.dart';

class ActionTile extends StatelessWidget {
  final String action;
  final Song song;
  final Color color;
  Icon? icon;

  ActionTile(
      {Key? key, required this.action, required this.song, required this.color})
      : super(key: key);

  get isFavorite => null;

  @override
  Widget build(BuildContext context) {
    // Icon icon = const Icon(Icons.cached);
    var isFavorite = context.watch<MusicProvider>().isFavorite;
    switch (action) {
      case 'Like':
        icon = Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          size: 22,
          color: isFavorite ? Colors.green : Colors.white,
        );
        break;
      case 'Share':
        icon = const Icon(
          Icons.ios_share,
          size: 22,
        );
        break;
      case 'Add to playlist':
        icon = const Icon(
          CupertinoIcons.music_note_list,
          size: 22,
        );
        break;
      case 'Add to queue':
        icon = const Icon(
          CupertinoIcons.text_badge_plus,
          size: 22,
        );
        break;
      case 'View album':
        icon = const Icon(
          CupertinoIcons.music_albums,
          size: 22,
        );
        break;
      case 'View artist':
        icon = const Icon(
          CupertinoIcons.person,
          size: 22,
        );
        break;
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: ListTile(
          title: Text(
            action,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: icon,
          onTap: () {
            switch (action) {
              case 'Like':
                _doActionLike(context);
                break;
              case 'Share':
                _doActionShare(context);
                break;
              case 'Add to playlist':
                _doActionAddPlaylist();
                break;
              case 'Add to queue':
                _doActionAddToQueue();
                break;
              case 'View album':
                _doActionViewAlbum(context);
                break;
              case 'View artist':
                _doActionViewArtist(context);
                break;
            }
          },
          // dense: true,
          horizontalTitleGap: 0,
        ));
  }
  _doActionLike(BuildContext context) {
    context.read<MusicProvider>().toggleFavorite();
  }

  _doActionShare(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SharePage(
            color: color,
            song: song,
          ),
        ));
  }
  _doActionAddToQueue() {}
  _doActionAddPlaylist() {}
  _doActionViewAlbum(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlbumView(
            image: AssetImage(song.coverUrl),
            label: song.description,
          ),
        ));
  }
  _doActionViewArtist(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArtistView(
            image: AssetImage(song.coverUrl),
            label: song.description,
          ),
        ));
  }
}
