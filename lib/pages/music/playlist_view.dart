import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/album/play_button.dart';
import 'package:spotify/components/album/song_tile.dart';
import 'package:spotify/components/artist/back_button.dart';
import 'package:spotify/components/playlist/playlist_component.dart';
import 'package:spotify/models/playlist.dart';
import 'package:spotify/pages/others/loading.dart';

import '../../components/album/animate_label.dart';
import '../../components/album/opacity_image.dart';
import '../../models/song.dart';
import '../../providers/data_provider.dart';
import '../../providers/music_provider.dart';
import '../../utils/db.dart';
import '../../utils/helper.dart';
import 'add_song.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({
    Key? key,
    required this.playlist,
    required this.image,
  }) : super(key: key);

  final Playlist playlist;
  final ImageProvider image;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
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

  bool isUserCreatePlaylist = false;

  // late ImageProvider imagePlaylist;

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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchSongs() async {
    if (widget.playlist.songIdList.isNotEmpty) {
      Future.wait(
        widget.playlist.songIdList.map((id) => Database.getSongById(id)),
      ).then((songs) {
        setState(() {
          songList = songs;
          _loading = false;
        });
      });
    }
    if (widget.playlist.type == 'user' && widget.playlist.songIdList.isEmpty) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future loadPlaylist() async {
    final currentPlaylistId =
        Provider.of<MusicProvider>(context, listen: false).currentPlaylistId;

    if (songList.isNotEmpty && currentPlaylistId != widget.playlist.id) {
      await context.read<MusicProvider>().loadPlaylist(songList);

      context
          .read<MusicProvider>()
          .updateCurrentPlaylist(widget.playlist.id, widget.playlist.name);
    }
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
    // if (widget.type == 'user' &&
    //     widget.id != context.watch<DataProvider>().user.id) {
    //   isUserCreatePlaylist = true;
    // }
    // if (isUserCreatePlaylist && songList.isNotEmpty) {
    //   imagePlaylist = getImageFromUrl(songList[0].coverImageUrl);
    //   context.read<DataProvider>().updateCoverImageUrlPlaylist(
    //       songList[0].coverImageUrl, widget.id);
    // } else {
    //   imagePlaylist = widget.image;
    // }

    if (_loading) {
      return const LoadingScreen();
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  height: 35,
                ),
                SafeArea(
                    child: OpacityImage(
                  imageOpacity: imageOpacity,
                  imageSize: imageSize,
                  image: widget.image,
                )),
              ],
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
                          SizedBox(height: initialImageSize + 31),
                          PlaylistComponent(
                            addSong: () async {
                              final newSongs = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddSong(
                                    id: widget.playlist.id,
                                    songList: songList,
                                  ),
                                ),
                              );

                              // for (final song in songList) {
                              //   if (song.audioUrl == '') {
                              //     song.audioUrl = await getFileFromFirebase(
                              //       '/song/audio/${song.id}.mp3',
                              //     );
                              //   }
                              //   context
                              //       .read<MusicProvider>()
                              //       .addToPlaylist(song);
                              // }

                              setState(() {
                                songList = [...songList, ...newSongs];
                              });
                            },
                            label: widget.playlist.name,
                            id: widget.playlist.id,
                            toggleFavorite: () {
                              context
                                  .read<DataProvider>()
                                  .toggleFavoritePlaylist(widget.playlist);
                            },
                            type: widget.playlist.type,
                            songList: songList,
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
                              .addToRecentPlayedList(widget.playlist);
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
                        label: widget.playlist.name,
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
                          .addToRecentPlayedList(widget.playlist);
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
