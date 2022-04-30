import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/album/album_component.dart';
import 'package:spotify/components/album/animate_label.dart';
import 'package:spotify/components/album/opacity_image.dart';
import 'package:spotify/components/album/play_button.dart';
import 'package:spotify/components/album/shuffle_button.dart';
import 'package:spotify/components/artist/back_button.dart';

import '../components/album/song_tile.dart';
import '../models/song.dart';
import '../providers/music_provider.dart';
import '../utils/firebase/db.dart';
import 'loading.dart';

class AlbumView extends StatefulWidget {
  const AlbumView(
      {Key? key,
      required this.image,
      required this.label,
      this.songIdList,
      required this.description})
      : super(key: key);

  final ImageProvider image;
  final String label;
  final String description;
  final List? songIdList;

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
    PaletteGenerator.fromImageProvider(widget.image).then((generator) {
      setState(() {
        _color = generator.mutedColor!.color;
      });
    });

    fetchSongs();
  }

  Future<void> fetchSongs() async {
    if (widget.songIdList != null) {
      final List<Song> songs = [];

      for (final id in widget.songIdList!) {
        final song = await Database.getSongById(id);

        songs.add(song);
      }

      setState(() {
        songList = songs;
      });

      context.read<MusicProvider>().loadPlaylist(songs);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (songList.isEmpty) {
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
                            label: widget.label,
                            description: widget.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: songList.map((item) {
                          return SongTile(song: item);
                        }).toList(),
                      ),
                      const SizedBox(height: 60)
                    ]
                  ),
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
                      AnimateLabel(label: widget.label, isShow: showTopBar),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom:
            645 - containerHeight.clamp(170, double.infinity),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: const [
                PLayButton(),
                ShuffleButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
