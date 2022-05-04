// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilesPage extends StatefulWidget {
  const EditProfilesPage({
    Key? key,
    required this.label,
    required this.image,
  }) : super(key: key);

  final String label;
  final ImageProvider image;

  @override
  State<EditProfilesPage> createState() => _EditProfilesPageState();
}

class _EditProfilesPageState extends State<EditProfilesPage> {
  var _image;
  var imagePicker;
  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  List<XFile>? imageFileList = [];
  // ignore: avoid_void_async
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), // here the desired height
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
                onPressed: () {},
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
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
                            _image,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : CircleAvatar(
                            backgroundImage: widget.image,
                            radius: 80,
                          )),
                TextButton(
                  onPressed: () async {
                    final XFile image1 = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                    );
                    final newImage = File(image1.path);
                    setState(() {
                      _image = newImage;
                    });
                  },
                  child: const Text('Edit profile image',
                      style: TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextFormField(
                    initialValue: widget.label,
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
