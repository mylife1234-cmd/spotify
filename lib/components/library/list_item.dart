import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.coverUrl,
    required this.isSquareCover,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String coverUrl;
  final bool isSquareCover;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: isSquareCover
            ? Image.asset(coverUrl)
            : CircleAvatar(
                foregroundImage: AssetImage(coverUrl),
                radius: 28,
              ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
