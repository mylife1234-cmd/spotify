import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/components/actions/action_tile.dart';
import 'package:spotify/components/actions/add_playlist_tile.dart';
import 'package:spotify/components/actions/add_queue_tile.dart';
import 'package:spotify/components/actions/like_tile.dart';
import 'package:spotify/components/actions/share_tile.dart';
import 'package:spotify/components/actions/view_artist_tile.dart';

import '../components/actions/view_album_tile.dart';
import '../models/song.dart';

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
                          color: widget.color,
                          action: item['text']!,
                          song: widget.song,
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
}

final listAction = [
  {
    'text': "Like",
  },
  {
    'text': "Share",
  },
  {
    'text': "View artist",
  },
  {
    'text': "Add to playlist",
  },
  {
    'text': "Add to queue",
  },
  {
    'text': "View album",
  },
];
