import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/album/album_component.dart';
import 'package:spotify/components/album/animate_label.dart';
import 'package:spotify/components/album/opacity_image.dart';
import 'package:spotify/components/album/play_button.dart';
import 'package:spotify/components/artist/back_button.dart';
import 'package:spotify/providers/data_provider.dart';

import '../../components/album/song_tile.dart';
import '../../models/album.dart';
import '../../models/song.dart';
import '../../providers/music_provider.dart';
import '../../utils/db.dart';
import '../../utils/helper.dart';
import '../others/loading.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({
    Key? key,
    required this.album,
    required this.image,
    required this.description,
  }) : super(key: key);

  final Album album;
  final ImageProvider image;
  final String description;

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late ScrollController scrollController;
  double imageSize = 0;
  double initialImageSize = 250;
  double containerHeight = 500;
  double containerInitialHeight = 500;
  double imageOpacity = 1;
  bool showTopBar = false;

  Color _color = Colors.black;
  List<Song> songList = [];
  bool _loading = true;

  @override
  void initState() {
    imageSize = initialImageSize;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialImageSize - scrollController.offset;
        if (imageSize < 0) {
          imageSize = 0;
        }
        containerHeight = containerInitialHeight - scrollController.offset;
        if (containerHeight < 0) {
          containerHeight = 0;
        }
        imageOpacity = imageSize / initialImageSize;
        if (scrollController.offset > 100) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }
        // print(imageSize);
        setState(() {});
      });
    super.initState();

    fetchSongs();
  }

  Future<void> fetchSongs() async {
    if (widget.album.songIdList.isNotEmpty) {
      Future.wait(
        widget.album.songIdList.map((id) => Database.getSongById(id)),
      ).then((songs) {
        setState(() {
          songList = songs;
          _loading = false;
        });
      });
    }
  }

  Future loadPlaylist() async {
    final currentPlaylistId =
        Provider.of<MusicProvider>(context, listen: false).currentPlaylistId;

    if (songList.isNotEmpty && currentPlaylistId != widget.album.id) {
      await context.read<MusicProvider>().loadPlaylist(songList);

      context
          .read<MusicProvider>()
          .updateCurrentPlaylist(widget.album.id, widget.album.name);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_color == Colors.black) {
      getColorFromImage(widget.image).then((color) {
        if (color != null) {
          setState(() {
            _color = color;
          });
        }
      });
    }
    if (_loading || songList.isEmpty) {
      return const LoadingScreen();
    }
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: containerHeight,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _color.withOpacity(1),
                    _color.withOpacity(0.7),
                    _color.withOpacity(0.5),
                    _color.withOpacity(0.3),
                    // Colors.black.withOpacity(0.1),
                    // Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(1),
                  ],
                ),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 19,
                  ),
                  SafeArea(
                    child: OpacityImage(
                      imageOpacity: imageOpacity,
                      imageSize: imageSize,
                      image: widget.image,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _color.withOpacity(0),
                          _color.withOpacity(0),
                          _color.withOpacity(0),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          SizedBox(height: initialImageSize),
                          AlbumComponent(
                            description: widget.description,
                            label: widget.album.name,
                            id: widget.album.id,
                            onTap: () {
                              context
                                  .read<DataProvider>()
                                  .toggleFavoriteAlbum(widget.album);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: songList.map((item) {
                      return GestureDetector(
                        onTap: () async {
                          await loadPlaylist();
                          context.read<MusicProvider>().playNewSong(item);
                          context
                              .read<DataProvider>()
                              .addToRecentPlayedList(widget.album);
                        },
                        child: SongTile(song: item),
                      );
                    }).toList(),
                  ),
                  if (songList.length == 3) const SizedBox(height: 20),
                  if (songList.length == 2) const SizedBox(height: 80),
                  if (songList.length == 1) const SizedBox(height: 140)
                ],
              ),
            ),
          ),
          Positioned(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: showTopBar ? _color.withOpacity(1) : _color.withOpacity(0),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              child: SafeArea(
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      const Positioned(
                        left: -5,
                        child: BackIconButton(),
                      ),
                      AnimateLabel(
                        label: widget.album.name,
                        isShow: showTopBar,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Stack(children: [
              Positioned(
                right: 12,
                top: containerHeight < containerInitialHeight
                    ? containerHeight.clamp(170, containerInitialHeight) - 140
                    : containerHeight.clamp(170, containerHeight) - 140,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    PLayButton(onTap: () async {
                      await loadPlaylist();
                      context.read<MusicProvider>().playWithIndex(0);
                      context
                          .read<DataProvider>()
                          .addToRecentPlayedList(widget.album);
                    }),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
