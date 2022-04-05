import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/actions/action_button.dart';
import 'package:spotify/components/actions/profile_button.dart';

import '../../models/song.dart';
import '../../providers/music_provider.dart';
import 'package:spotify/pages/profile.dart';
class SettingTile extends StatelessWidget {
  const SettingTile({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    var currentSong = context.watch<MusicProvider>().currentSong;

    final isCurrent = currentSong!.name == song.name;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.black,
      child: ListTile(
        title: Text(
          song.name,
          style: TextStyle(
            fontWeight:FontWeight.bold,
            color: Colors.white,
            fontSize: 16
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          song.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading:CircleAvatar(
          backgroundImage:AssetImage(song.coverUrl),
        ),
        trailing: ProfileButton(song: song, size: 19),
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 12,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              //return const SearchPlayList();
              return  ProfilePage();
            }),
          );
        },
      ),
    );
  }
}
