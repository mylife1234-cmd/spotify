import 'package:flutter/material.dart';
import 'package:spotify/components/home/history_button.dart';
import 'package:spotify/pages/recently_played.dart';

import 'settings_button.dart';

class HeaderButtons extends StatelessWidget {
  const HeaderButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        // Icon(Icons.notifications),
        SizedBox(width: 15),
        HistoryButton(),
        SizedBox(width: 15),
        SettingsButton(size: 24)
      ],
    );
  }
}
