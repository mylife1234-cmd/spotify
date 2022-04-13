import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/actions/action_tile.dart';
import 'package:spotify/components/share/song_info.dart';
import 'package:spotify/main.dart';
import 'package:spotify/pages/share_page.dart';

import '../models/song.dart';
import '../providers/music_provider.dart';
import 'album_view.dart';
import 'artist_view.dart';

class SongAction extends StatefulWidget {
  const SongAction({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  _SongActionState createState() => _SongActionState();
}

class _SongActionState extends State<SongAction> {
  Color _color = Colors.black;

  final homeContext = getIt.get<BuildContext>(instanceName: 'homeContext');

  @override
  void initState() {
    super.initState();
    PaletteGenerator.fromImageProvider(AssetImage(widget.song.coverUrl))
        .then((generator) {
      setState(() {
        _color = generator.mutedColor!.color;
      });
    });
  }

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
        () => _doActionLike(),
      ),
      Action(
        'Share',
        const Icon(
          Icons.ios_share,
          size: 22,
        ),
        () => _doActionShare(),
      ),
      Action(
        'View artist',
        const Icon(
          CupertinoIcons.person,
          size: 22,
        ),
        () => _doActionViewArtist(),
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
        () => _doActionViewAlbum(),
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
                      _color.withOpacity(0.6),
                      _color.withOpacity(0.5),
                      _color.withOpacity(0.4),
                      _color.withOpacity(0.3),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.6),
                    ]),
              ),
              child: SafeArea(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 44,
                    ),
                    SongInfo(song: widget.song),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listAction.map((item) {
                        return ActionTile(
                          title: item.title,
                          leading: item.leading,
                          color: _color,
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

  _doActionLike() {
    context.read<MusicProvider>().toggleFavorite();
  }

  _doActionShare() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SharePage(
          song: widget.song,
        ),
      ),
    );
  }

  _doActionAddToQueue() {}

  _doActionAddPlaylist() {}

  _doActionViewAlbum() async {
    Navigator.popUntil(homeContext, (route) => route.isFirst);

    Navigator.popUntil(context, (route) => route.isFirst);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    await Navigator.push(
      homeContext,
      MaterialPageRoute(
        builder: (context) => AlbumView(
          image: AssetImage(widget.song.coverUrl),
          label: widget.song.description,
        ),
      ),
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
  }

  _doActionViewArtist() {
    Navigator.popUntil(homeContext, (route) => route.isFirst);

    Navigator.popUntil(context, (route) => route.isFirst);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    Navigator.push(
      homeContext,
      MaterialPageRoute(
        builder: (context) => ArtistView(
          image: AssetImage(widget.song.coverUrl),
          label: widget.song.description,
        ),
      ),
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
  }
}

class Action {
  Action(this.title, this.leading, this.onTap);

  final String title;
  final Widget leading;
  final void Function() onTap;
}
