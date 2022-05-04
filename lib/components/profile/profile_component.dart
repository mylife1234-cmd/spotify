import 'package:flutter/material.dart';
import 'package:spotify/components/profile/edit_profile_button.dart';
import 'package:spotify/pages/edit_profile.dart';

class ProfileComponent extends StatelessWidget {
  final String label;
  final ImageProvider image;
  const ProfileComponent({Key? key, required this.label, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20, top: 50, bottom: 0),
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
          child:Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: ProfileButton(
                title: "Edit profile",
                active: false,
              ),
            ),
          ) ,
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  //return const SearchPlayList();
                  return EditProfilesPage(
                  label: label, image: image);
                })
            );
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children:[
                  Text(
                    "20",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Followers",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "12",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Follow",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
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
            "Playlists",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}
