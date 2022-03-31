import 'package:flutter/material.dart';

import '../../models/song.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final Song song;
  final Color color;
  final Widget leading;
  final void Function()? onTap;

  const ActionTile({
    Key? key,
    required this.title,
    required this.song,
    required this.color,
    required this.leading,
    this.onTap,
  }) : super(key: key);

  get isFavorite => null;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(.6),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: leading,
          onTap: onTap,
          // dense: true,
          horizontalTitleGap: 0,
        ));
  }
}
