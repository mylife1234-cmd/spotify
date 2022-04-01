import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/components/artist/back_button.dart';
import 'package:spotify/components/share/media_button.dart';
import 'package:spotify/components/share/song_info.dart';
import 'package:spotify/models/song.dart';

class SharePage extends StatefulWidget {
  final Color color;
  final Song song;
  const SharePage({Key? key, required this.color, required this.song})
      : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
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
                      widget.color.withOpacity(0.4),
                      widget.color.withOpacity(0.3),
                      widget.color.withOpacity(0.2),
                      // Colors.black.withOpacity(0.1),
                      // Colors.transparent,
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(1),
                    ]),
              ),
              child: SafeArea(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    SongInfo(song: widget.song),
                    _buildGridViewMedia(),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 9,
            child: SafeArea(
              child: BackIconButton(),
            ),
          ),
        ],
      ),
    );
  }
}

_buildGridViewMedia() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: GridView.builder(
        itemCount: listMedia.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          // crossAxisSpacing: 0,
        ),
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        itemBuilder: (BuildContext context, int index) {
          final item1 = listMedia[index];
          return MediaButton(text: item1['text']!, coverUrl: item1['icon']!);
        }),
  );
}

final listMedia = [
  {
    'text': "FaceBook",
    'icon': "assets/images/brands/facebook1.png",
  },
  {
    'text': "Twitter",
    'icon': "assets/images/brands/twitter.png",
  },
  {
    'text': "Messenger",
    'icon': 'assets/images/brands/messenger.png',
  },
  {
    'text': "Instagram",
    'icon': 'assets/images/brands/instagram2.png',
  },
  {
    'text': "WhatsApp",
    'icon': 'assets/images/brands/whatsapp.png',
  },
  {
    'text': "Telegram",
    'icon': 'assets/images/brands/telegram.png',
  },
];
