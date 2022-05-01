import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/components/auth/next_button.dart';
import 'package:spotify/components/setting/setting_title.dart';
import 'package:spotify/main.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/providers/music_provider.dart';

import '../models/setting.dart';

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
            children: [
              //temp
              // SettingInfo(
              //   song: Song(
              //     FirebaseAuth.instance.currentUser!.displayName!,
              //     'View Profile',
              //     'assets/images/den-vau.jpeg',
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: songList.map((item) {
                      return SettingList(
                        song: SettingTitle(
                          item['title']!,
                        ),
                      );
                    }).toList()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Center(
                  child: NextButton(
                    label: 'Log out',
                    color: Colors.white,
                    onTap: () async {
                      getIt.unregister<BuildContext>(
                        instanceName: 'homeContext',
                      );

                      context.read<MusicProvider>().clear();

                      context.read<DataProvider>().clear();

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
