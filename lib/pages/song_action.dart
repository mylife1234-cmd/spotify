import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/song.dart';

class SongAction extends StatefulWidget {
  const SongAction({Key? key, required this.color, required this.song}) : super(key: key);
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
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
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
                      padding: const EdgeInsets.only(top: 15,  bottom: 30),
                      child: Text(
                        widget.song.description,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top:9,
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
