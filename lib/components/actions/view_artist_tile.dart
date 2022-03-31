import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/models/song.dart';
import 'package:spotify/pages/artist_view.dart';

class ViewArtistTile extends StatelessWidget {
  final Song song;
  const ViewArtistTile({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: MediaQuery.of(context).size.width,
      color:Colors.black,
      child: ListTile(
        title: const Text(
          'View artist',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const Icon(
          CupertinoIcons.person,
          size: 22,
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArtistView(
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
