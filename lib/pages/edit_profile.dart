// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/utils/helper.dart';

class EditProfilesPage extends StatefulWidget {
  const EditProfilesPage({Key? key}) : super(key: key);

  @override
  State<EditProfilesPage> createState() => _EditProfilesPageState();
}

class _EditProfilesPageState extends State<EditProfilesPage> {
  final controller = TextEditingController();

  final imagePicker = ImagePicker();

  File? _image;

  @override
  Widget build(BuildContext context) {
    final user = context.read<DataProvider>().user;

    controller.text = user.name;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            leading: GestureDetector(
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (controller.text != user.name) {
                    FirebaseAuth.instance.currentUser!
                        .updateDisplayName(controller.text);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ClipOval(
                  child: _image != null
                      ? Image.file(
                          _image!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : CircleAvatar(
                          backgroundImage: getImageFromUrl(user.coverImageUrl),
                          radius: 80,
                        ),
                ),
                TextButton(
                  onPressed: () async {
                    final image = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                    );

                    final newImage = File(image!.path);

                    setState(() {
                      _image = newImage;
                    });
                  },
                  child: const Text(
                    'Edit profile image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    controller: controller,
                    cursorColor: Colors.grey,
                    style: const TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final songList = [
  {
    'title': 'Account',
  },
  {
    'title': 'Data Saver',
  },
  {
    'title': 'Languages',
  },
  {
    'title': 'Playback',
  },
  {
    'title': 'Social',
  },
];
