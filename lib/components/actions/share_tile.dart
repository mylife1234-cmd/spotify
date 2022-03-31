import 'package:flutter/material.dart';
import 'package:spotify/models/song.dart';

import '../../pages/share_page.dart';

class ShareTile extends StatelessWidget {
  final Song song;
  final Color color;

  const ShareTile({Key? key, required this.song, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: MediaQuery.of(context).size.width,
      color:Colors.black,
      child: ListTile(
        title: const Text(
          'Share',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const Icon(
          Icons.ios_share,
          size: 22,
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SharePage(
                  color: color,
                  song: song,
                ),
              ));
        },
        // dense: true,
        horizontalTitleGap: 0,
      ),

    );
  }
}
