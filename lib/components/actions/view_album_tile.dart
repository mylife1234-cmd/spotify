import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/pages/album_view.dart';

import '../../models/song.dart';

class ViewAlbumTile extends StatelessWidget {
  final Song song;
  const ViewAlbumTile({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: MediaQuery.of(context).size.width,
      color:Colors.black,
      child: ListTile(
        title: const Text(
          'View album',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const Icon(
          CupertinoIcons.music_albums,
          size: 22,
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlbumView(
                  image: AssetImage(song.coverUrl),
                  label: song.description,
                ),
              ));
        },
        // dense: true,
        horizontalTitleGap: 0,
      ),

    );
  }
}
