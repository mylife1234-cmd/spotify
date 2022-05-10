import 'package:flutter/material.dart';
import 'package:spotify/pages/edit_profile.dart';

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({
    Key? key,
    required this.label,
    required this.image,
  }) : super(key: key);

  final String label;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 35),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                border: Border.all(width: 1.5, color: Colors.white54),
                color: Colors.black,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text('Edit profile', style: TextStyle(fontSize: 12)),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const EditProfilesPage();
            }));
          },
        ),
        const Text(
          'Playlists',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
