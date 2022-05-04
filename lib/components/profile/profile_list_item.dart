import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.black,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 16),
        ),
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