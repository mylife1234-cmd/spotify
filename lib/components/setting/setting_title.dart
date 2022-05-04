import 'package:flutter/material.dart';
import 'package:spotify/pages/about_detail.dart';
import 'package:spotify/pages/account_detail.dart';
import 'package:spotify/pages/setting.dart';
import 'package:spotify/pages/storage_detail.dart';

import '../../models/setting.dart';

class SettingList extends StatelessWidget {
  const SettingList({Key? key, required this.settingTitle}) : super(key: key);

  final SettingTitle settingTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.black,
      child: ListTile(
        title: Text(
          settingTitle.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 12,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              //return const SearchPlayList();
              if (settingTitle.name == 'Account') {
                return const AccountDetailPage();
              }
              if (settingTitle.name == 'Device') {
                return const StorageDetailPage();
              }
              if (settingTitle.name == 'About') {
                return const AboutDetailPage();
              }
              return const SettingsPage();
            }),
          );
        },
      ),
    );
  }
}
