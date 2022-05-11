import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/profile/profile.dart';

import '../../pages/home/recently_played.dart';
import '../../providers/data_provider.dart';
import '../../providers/music_provider.dart';

class HeaderButtons extends StatelessWidget {
  const HeaderButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: const Icon(Icons.history, size: 22),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RecentlyPlayed()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            child: const Icon(Icons.person),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProfilePage();
              }));
            },
          ),
        ),
        GestureDetector(
          child: const Icon(Icons.logout_outlined, size: 22),
          onTap: () async {
            context.read<MusicProvider>().clear();

            context.read<DataProvider>().clear();

            await FirebaseAuth.instance.signOut();
          },
        )
      ],
    );
  }
}
