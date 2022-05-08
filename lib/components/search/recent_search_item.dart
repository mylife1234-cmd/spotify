import 'package:flutter/material.dart';

import '../../utils/helper.dart';

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.coverUrl,
    required this.isSquareCover,
    required this.id,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String id;
  final String subtitle;
  final String coverUrl;
  final bool isSquareCover;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final image = getImageFromUrl(coverUrl);

    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: ListTile(
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(subtitle),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.close),
        ),
        leading: isSquareCover
            ? Image(image: image)
            : CircleAvatar(foregroundImage: image, radius: 28),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
