import 'package:flutter/material.dart';
import 'package:spotify/pages/recently_played.dart';

class HistoryButton extends StatelessWidget {
  const HistoryButton({
    Key? key,
    this.size,
  }) : super(key: key);
  final double? size;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.history,
        size: size,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecentlyPlayed()),
        );
      },
    );
  }
}
