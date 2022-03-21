// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/album/song_title.dart';
import 'package:spotify/components/player/miniplayer.dart';

import '../models/song.dart';
import '../providers/music_provider.dart';

class AlbumView extends StatefulWidget {
  final AssetImage image;
  final String label;

  const AlbumView({Key? key, required this.image, required this.label})
      : super(key: key);

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

        // print("ScrollController:");
        // print(scrollController.offset);
        // print("Container_Height:");
        // print(containerHeight);
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _currentSong = context.watch<MusicProvider>().currentSong;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: containerHeight,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.white54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: imageOpacity.clamp(0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: Offset(0, 10),
                          blurRadius: 22,
                          spreadRadius: 12,
                        )
                      ],
                    ),
                    child: Image(
                      // image: widget.image,
                      image: widget.image,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 550,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(1),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: initialImageSize + 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        widget.label,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/images/logo_spotify.png"),
                                            width: 20,
                                            height: 20,
                                          ),
                                          SizedBox(width: 7),
                                          Text("Spotify",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      "1,999,890 likes 9h 56m",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_outline_rounded,
                                          size: 22,
                                        ),
                                        SizedBox(width: 15),
                                        Icon(
                                          CupertinoIcons.arrow_down_circle,
                                          size: 22,
                                        ),
                                        SizedBox(width: 15),
                                        Icon(
                                          Icons.more_horiz,
                                          size: 22,
                                        ),
                                      ],
                                    )

                                  ]),
                            ),
                          ],
                        ),
                      )),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: songList.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 5),
                        child: SongTitle(
                          song: Song

                          (item['name'] !, item['description'] !, item['coverUrl']!)
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              child: Container(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: showTopBar
                  ? Color.fromARGB(251, 82, 71, 71).withOpacity(1)
                  : Color(0xffc858585).withOpacity(0),
              padding: EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 7,
              ),
              child: SafeArea(
                child: Container(
                  height: 38,
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.centerLeft,
                    children: [
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 35,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 200),
                        opacity: showTopBar ? 1 : 0,
                        child: Container(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Text(
                            widget.label,
                            // style: Theme.of(context).textTheme.headline6,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom:
                            126 - containerHeight.clamp(160.0, double.infinity),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                size: 35,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff2a2a2a),
                              ),
                              child: Icon(
                                CupertinoIcons.shuffle,
                                color: Colors.green,
                                size: 12,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),

          // _currentSong == null  ? AlbumView(image: widget.image, label: widget.label):
          //   Align(
          //     child: MiniPlayer(song: _currentSong),
          //     alignment: Alignment.bottomCenter,
          //   )
          //
        ],
      ),
    );
  }
}

 final songList =
 [
   {
    'name': "K/DA",
    'description': "Riot",
    'coverUrl': "assets/images/home/kda.jpg",
  },
  {
    'name': "Big City Boi",
    'description': "Binz",
    'coverUrl': "assets/images/home/big-city-boi.jpg",
  },
  {
    'name': "DNA",
    'description': "BTS",
    'coverUrl': "assets/images/home/dna.jpg",
  },
  {
    'name': "Latata",
    'description': "G(I)-DLE",
    'coverUrl': "assets/images/home/latata.jpg",
  },
  {
    'name': "Chilled",
    'description': "Nhạc nhẹ",
    'coverUrl': "assets/images/home/chilled.jpg",
  },
  {
    'name': "Ái nộ",
    'description': "Masew",
    'coverUrl': "assets/images/home/ai-no.jpg",
  },
  {
    'name': "Relax",
    'description': "Album2",
    'coverUrl': "assets/images/home/album2.jpg",
  },
   {
     'name': "Mang tiền về cho mẹ",
     'description': "Đen vâu",
     'coverUrl': "assets/images/den-vau.jpeg",
   },
   {
     'name': "Maroon5",
     'description': "Binz",
     'coverUrl': "assets/images/maroon5.jpeg",
   },
   {
     'name': "Cảm ơn",
     'description': "Đen",
     'coverUrl': "assets/images/cam-on.jpg",
   },
];
