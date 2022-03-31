import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/music_provider.dart';

class LikeTile extends StatelessWidget {
  const LikeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var isFavorite =  false;
    var isFavorite = context.watch<MusicProvider>().isFavorite;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: MediaQuery.of(context).size.width,
      color:Colors.black,
      child: ListTile(
        title: const Text(
          'Like',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          size: 22,
          color: isFavorite ? Colors.green : Colors.white,
        ),
        // dense: true,
        // visualDensity: VisualDensity.standard,
        onTap: (){
          // isFavorite = !isFavorite;
          context.read<MusicProvider>().toggleFavorite();
        },
        // dense: true,
        horizontalTitleGap: 0,
      ),

    );
  }

}
