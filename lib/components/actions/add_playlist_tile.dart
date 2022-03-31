import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPlaylistTile extends StatelessWidget {
  const AddPlaylistTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: MediaQuery.of(context).size.width,
      color:Colors.black,
      child: ListTile(
        title: const Text(
          'Add to playlist',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const Icon(
          CupertinoIcons.music_note_list,
          size: 22,
        ),
        onTap: (){
        },
        // dense: true,
        horizontalTitleGap: 0,
      ),

    );
  }
}
