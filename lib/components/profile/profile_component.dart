import 'package:flutter/material.dart';
import 'package:spotify/components/profile/edit_profile_button.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: ProfileButton(
                title: 'Edit profile',
                active: false,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              //return const SearchPlayList();
              return const EditProfilesPage();
            }));
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: const [
                  Text(
                    '20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Followers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: const [
                  Text(
                    '12',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Follow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text(
            'Playlists',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}
