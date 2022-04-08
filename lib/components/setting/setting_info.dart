import 'package:flutter/material.dart';

import '../../models/song.dart';
import 'package:spotify/pages/profile.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.black,
      child: ListTile(
        title: Text(
          song.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          song.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: CircleAvatar(backgroundImage: AssetImage(song.coverUrl)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 19),
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 12,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              //return const SearchPlayList();
              return const ProfilePage();
            }),
          );
        },
      ),
    );
  }
}
