import 'package:flutter/material.dart';
import 'package:spotify/pages/setting.dart';

class SettingsButton extends StatelessWidget {
  final double size;

  const SettingsButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.settings,
        size: size,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
      },
    );
  }
}
