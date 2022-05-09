
import 'package:flutter/material.dart';
import 'package:spotify/components/library/grid_item.dart';
import 'package:spotify/pages/playlist_view.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/song_action.dart';
import 'package:spotify/providers/data_provider.dart';
import '../components/album/animate_label.dart';
import '../components/artist/back_button.dart';
import '../models/song.dart';
import '../utils/helper.dart';
import 'album_view.dart';
import 'loading.dart';

class GenrePage extends StatefulWidget {
  final String label;
  final ImageProvider image;
  final String id;

  const GenrePage({Key? key, required this.label, required this.image})
      : super(key: key);

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  bool showTopBar = false;
  final Color _color = Colors.red;
  late ScrollController scrollController;
  final double initContainerHeight = 150;
  double containerHeight = 150;

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        containerHeight = initContainerHeight - scrollController.offset;
        if (containerHeight < 0) {
          containerHeight = initContainerHeight;
        }
        if (scrollController.offset > 100) {
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
    // if (_color == Colors.black) {
    //   getColorFromImage(widget.image).then((color) {
    //     if (color != null) {
    //       setState(() {
    //         _color = color;
    //       });
    //     }
    //   });
    // }
    // final songs = context.watch<DataProvider>().songs;
    if (_loading || songList.isEmpty) {
      return const LoadingScreen();
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
          // Container(
          //   width:  MediaQuery.of(context).size.width,
          //   height: containerHeight,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 90, bottom: 10, left: 20),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           widget.label,
          //           style: const TextStyle(
          //             fontSize: 25,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 85),
            child: GridView.count(
              controller: scrollController,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 16,
              childAspectRatio: cardWidth / (cardWidth + 60),
              children: songList.map<Widget>((item) {
                return GestureDetector(
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
                        left: -3,
                        child: BackIconButton(),
                      ),
                      AnimateLabel(label: widget.label, isShow: showTopBar),
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

  void onTap(item) {
    final image = getImageFromUrl(item.coverImageUrl);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (item.runtimeType.toString() == 'Playlist') {
            return PlaylistView(
                id: item.id,
                image: image,
                label: item.name,
                songIdList: item.songIdList);
          }
          if (item.runtimeType.toString() == 'Album') {
            return AlbumView(
                id: item.id,
                image: image,
                label: item.name,
                description: item.description,
                songIdList: item.songIdList);
          }
          return SongAction(song: item);
        },
      ),
    );
  }
}
