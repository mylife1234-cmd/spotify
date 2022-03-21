// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

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
  double initialImageSize = 220;
  double containerHeight = 500;
  double containerinitalHeight = 500;
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
        containerHeight = containerinitalHeight - scrollController.offset;
        if (containerHeight < 0) {
          containerHeight = 0;
        }
        imageOpacity = imageSize / initialImageSize;
        if (scrollController.offset > 100) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }

        print("ScrollController:");
        print(scrollController.offset);
        // print("Container_Height:");
        // print(containerHeight);
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            SingleChildScrollView(
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
                            SizedBox(height: initialImageSize + 50),
                            Padding(
                              padding: const EdgeInsets.all(20),
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
                                      padding: EdgeInsets.only(top: 10),
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
                                          Icons.favorite,
                                          size: 18,
                                        ),
                                        SizedBox(width: 15),
                                        Icon(
                                          Icons.download,
                                          size: 18,
                                        ),
                                        SizedBox(width: 15),
                                        Icon(
                                          Icons.more_horiz,
                                          size: 18,
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    color: Colors.black.withOpacity(1),
                    height: 600,
                  )
                ],
              ),
            ),
            Positioned(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                color: showTopBar
                    ? Color.fromARGB(251, 82, 71, 71).withOpacity(1)
                    : Color(0xFFC858585).withOpacity(0),
                padding: EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 7,
                ),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  // alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
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
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            widget.label,
                            style: Theme.of(context).textTheme.bodyText1,
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
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.shuffle,
                                color: Colors.black,
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
            )
          ],
        ),
      ),
    );
  }
}
