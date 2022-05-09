import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/library/grid_item.dart';
import 'package:spotify/providers/data_provider.dart';
import '../components/album/animate_label.dart';
import '../components/artist/back_button.dart';
import '../models/song.dart';
import '../providers/music_provider.dart';
import '../utils/helper.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({
    Key? key,
    required this.name,
    required this.image,
    required this.id,
  }) : super(key: key);

  final String name;
  final ImageProvider image;
  final String id;
  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  bool showTopBar = false;
  late Color _color = Colors.black;
  late ScrollController scrollController;
  List<Song> songList = [];

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset > 10) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }
        // print(imageSize);
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songs = context.watch<DataProvider>().songs;
    // songList = songs
    //   ..removeWhere(
    //         (element) => !element.genreIdList.contains(widget.id),
    //   );
    for (int i = 0; i < songs.length; i++) {
      if (songs[i].genreIdList.contains(widget.id)) {
        if (!songList.any((element) => element.id == songs[i].id)) {
          songList.add(songs[i]);
        }
      }
    }
    if (_color == Colors.black) {
      getColorFromImage(widget.image).then((color) {
        if (color != null) {
          setState(() {
            _color = color;
          });
        }
      });
    }

    final width = MediaQuery.of(context).size.width;
    final cardWidth = (width - 35) / 2;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _color.withOpacity(0.4),
                    _color.withOpacity(0.3),
                    _color.withOpacity(0.2),
                    // Colors.black.withOpacity(0.1),
                    // Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(1),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 60),
            child: GridView.count(
              controller: scrollController,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: cardWidth / (cardWidth + 60),
              children: songList.map<Widget>((item) {
                return GestureDetector(
                  onTap: () async {
                    final currentPlaylistId =
                        Provider.of<MusicProvider>(context, listen: false)
                            .currentPlaylistId;

                    if (currentPlaylistId != item.id) {
                      if (item.audioUrl == '') {
                        item.audioUrl = await getFileFromFirebase(
                            '/song/audio/${item.id}.mp3');
                      }

                      await context.read<MusicProvider>().loadPlaylist([item]);

                      context
                          .read<MusicProvider>()
                          .updateCurrentPlaylist(item.id, 'Song');
                    }
                    context.read<DataProvider>().addToRecentSearchList(item);
                    context.read<MusicProvider>().playNewSong(item);
                  },
                  child: GridItem(
                    title: item.name,
                    subtitle: item.description,
                    coverUrl: item.coverImageUrl,
                    isSquareCover: item.runtimeType.toString() != 'Artist',
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
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
                        left: -15,
                        child: BackIconButton(),
                      ),
                      AnimateLabel(label: widget.name, isShow: true),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
