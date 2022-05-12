import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/music/playlist/playlist_view.dart';
import 'package:spotify/utils/helper.dart';

import '../../components/library/list_item.dart';
import '../../providers/data_provider.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final playlists = [
      ...context.watch<DataProvider>().favoritePlaylists,
      ...context.watch<DataProvider>().customizedPlaylists,
    ];

    final user = context.watch<DataProvider>().user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          iconSize: 24,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CircleAvatar(
                      radius: 130 / 2,
                      backgroundImage: getImageFromUrl(user.coverImageUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        border: Border.all(width: 1.5, color: Colors.white54),
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const EditProfilePage();
                      },
                    )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 35),
                    child: Text(
                      'Playlists',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...playlists.map((item) {
                    return GestureDetector(
                      child: ListItem(
                        title: item.name,
                        subtitle: item.runtimeType.toString(),
                        coverUrl: item.coverImageUrl,
                        isSquareCover: item.runtimeType.toString() != 'Artist',
                      ),
                      onTap: () => onTap(item),
                    );
                  }).toList(),
                  if (playlists.length == 3) const SizedBox(height: 140),
                  if (playlists.length == 2) const SizedBox(height: 200),
                  if (playlists.length == 1) const SizedBox(height: 250)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(item) {
    final image = getImageFromUrl(item.coverImageUrl);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PlaylistView(playlist: item, image: image);
      }),
    );
  }
}
