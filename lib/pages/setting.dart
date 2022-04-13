import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify/components/auth/next_button.dart';
import '../models/song.dart';
import '../models/setting.dart';
import 'package:spotify/components/setting/setting_info.dart';
import 'package:spotify/components/setting/setting_title.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SettingInfo(
                song: Song(
                  FirebaseAuth.instance.currentUser!.displayName!,
                  "View Profile",
                  "assets/images/den-vau.jpeg",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:songList.map((item) {
                    return SettingList(
                      song: SettingTitle(
                        item['title']!,
                      ),
                    );
                  }).toList()
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Center(
                  child: NextButton(
                    label: 'Log out',
                    color: Colors.white,
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final songList = [
  {
    'title': 'Account',
  },
  {
    'title': 'Data Saver',
  },
  {
    'title': 'Languages',
  },
  {
    'title': 'Playback',
  },
  {
    'title': 'Social',
  },
];
