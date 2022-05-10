import 'package:flutter/material.dart';
import 'package:spotify/pages/profile.dart';
import 'package:spotify/utils/helper.dart';

import '../../models/user.dart';

class SettingInfo extends StatelessWidget {
  const SettingInfo({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    final image = getImageFromUrl(user.coverImageUrl);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.black,
      child: ListTile(
        title: Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: const Text(
          'View Profile',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: CircleAvatar(backgroundImage: image, radius: 20),
        trailing: const Icon(Icons.arrow_forward_ios, size: 19),
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 12,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return const ProfilePage();
            }),
          );
        },
      ),
    );
  }
}
