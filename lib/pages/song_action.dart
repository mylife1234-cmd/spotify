import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/actions/action_tile.dart';
import 'package:spotify/pages/share_page.dart';

import '../models/song.dart';
import '../providers/music_provider.dart';
import 'album_view.dart';
import 'artist_view.dart';

class SongAction extends StatefulWidget {
  const SongAction({Key? key, required this.color, required this.song})
      : super(key: key);
  final Color color;
  final Song song;

  @override
  _SongActionState createState() => _SongActionState();
}

class _SongActionState extends State<SongAction> {
  @override
  Widget build(BuildContext context) {
    var isFavorite = context.watch<MusicProvider>().isFavorite;

    final listAction = [
      Action(
        'Like',
        Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          size: 22,
          color: isFavorite ? Colors.green : Colors.white,
        ),
            () => _doActionLike(context),
      ),
      Action(
        'Share',
        const Icon(
          Icons.ios_share,
          size: 22,
        ),
            () => _doActionShare(context),
      ),
      Action(
        'View artist',
        const Icon(
          CupertinoIcons.person,
          size: 22,
        ),
            () => _doActionViewArtist(context),
      ),
      Action(
        'Add to playlist',
        const Icon(
          CupertinoIcons.music_note_list,
          size: 22,
        ),
            () => _doActionAddPlaylist(),
      ),
      Action(
        'Add to queue',
        const Icon(
          CupertinoIcons.text_badge_plus,
          size: 22,
        ),
            () => _doActionAddToQueue(),
      ),
      Action(
        'View album',
        const Icon(
          CupertinoIcons.music_albums,
          size: 22,
        ),
            () => _doActionViewAlbum(context),
      )
    ];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            // physics: const BouncingScrollPhysics(),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.color.withOpacity(0.5),
                      widget.color.withOpacity(0.4),
                      widget.color.withOpacity(0.3),
                      // widget.color.withOpacity(0.3),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(1),
                    ]),
              ),
              child: SafeArea(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 44),
                      child: Image(
                        image: AssetImage(widget.song.coverUrl),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 180,
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        widget.song.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            letterSpacing: 0.2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        widget.song.description,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    // Column(
                    //   children: [
                    //     const LikeTile(),
                    //     ViewArtistTile(
                    //       song: widget.song,
                    //     ),
                    //     const AddPlaylistTile(),
                    //     const AddToQueueTile(),
                    //     ShareTile(
                    //       song: widget.song,
                    //       color: widget.color,
                    //     ),
                    //     ViewAlbumTile(
                    //       song: widget.song,
                    //     ),
                    //   ],
                    // )
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listAction.map((item) {
                        return ActionTile(
                          title: item.title,
                          leading: item.leading,
                          color: widget.color,
                          song: widget.song,
                          onTap: item.onTap,
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 29,
            child: SafeArea(
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.chevron_back),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _doActionLike(BuildContext context) {
    context.read<MusicProvider>().toggleFavorite();
  }

  _doActionShare(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SharePage(
            color: widget.color,
            song: widget.song,
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
            image: AssetImage(widget.song.coverUrl),
            label: widget.song.description,
          ),
        ));
  }

  _doActionViewArtist(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArtistView(
            image: AssetImage(widget.song.coverUrl),
            label: widget.song.description,
          ),
        ));
  }
}

class Action {
  Action(this.title, this.leading, this.onTap);

  final String title;
  final Widget leading;
  final void Function() onTap;
}
