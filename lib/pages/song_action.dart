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

  ImageProvider? image;

  @override
  void initState() {
    super.initState();

    final url = widget.song.coverImageUrl;

    setState(() {
      if (url.startsWith('https')) {
        image = NetworkImage(url);
      } else {
        image = AssetImage(url);
      }
    });

    PaletteGenerator.fromImageProvider(image!).then((generator) {
      setState(() {
        _color = generator.mutedColor!.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<MusicProvider>().isFavorite;

    final listAction = [
      Action(
        'Like',
        Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          size: 22,
          color: isFavorite ? Colors.green : Colors.white,
        ),
        _doActionLike,
      ),
      Action(
        'Share',
        const Icon(
          Icons.ios_share,
          size: 22,
        ),
        _doActionShare,
      ),
      Action(
        'View artist',
        const Icon(
          CupertinoIcons.person,
          size: 22,
        ),
        _doActionViewArtist,
      ),
      Action(
        'Add to playlist',
        const Icon(
          CupertinoIcons.music_note_list,
          size: 22,
        ),
        _doActionAddPlaylist,
      ),
      Action(
        'Add to queue',
        const Icon(
          CupertinoIcons.text_badge_plus,
          size: 22,
        ),
        _doActionAddToQueue,
      ),
      Action(
        'View album',
        const Icon(
          CupertinoIcons.music_albums,
          size: 22,
        ),
        _doActionViewAlbum,
      )
    ];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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

  void _doActionLike() {
    context.read<MusicProvider>().toggleFavorite();
  }

  void _doActionShare() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SharePage(
          song: widget.song,
        ),
      ),
    );
  }

  void _doActionAddToQueue() {}

  void _doActionAddPlaylist() {}

  Future _doActionViewAlbum() async {
    Navigator.popUntil(homeContext, (route) => route.isFirst);

    Navigator.popUntil(context, (route) => route.isFirst);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    await Navigator.push(
      homeContext,
      MaterialPageRoute(
        builder: (context) => AlbumView(
          image: image!,
          label: widget.song.description,
        ),
      ),
    );

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
  }

  void _doActionViewArtist() {
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
          image: image!,
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
