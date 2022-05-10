// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spotify/providers/data_provider.dart';
import 'package:spotify/utils/helper.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final controller = TextEditingController();

  final imagePicker = ImagePicker();

  File? _image;

  @override
  Widget build(BuildContext context) {
    final user = context.read<DataProvider>().user;

    controller.text = user.name;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: GestureDetector(
            child: const Icon(Icons.close, color: Colors.white, size: 20),
            onTap: () => Navigator.maybePop(context),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text != user.name) {
                  FirebaseAuth.instance.currentUser!
                      .updateDisplayName(controller.text);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: _image != null
                        ? FileImage(_image!)
                        : getImageFromUrl(user.coverImageUrl),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: GestureDetector(
                  onTap: () async {
                    final image = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                    );

                    final newImage = File(image!.path);

                    setState(() {
                      _image = newImage;
                    });
                  },
                  child: const Text('Change photo'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: controller,
                  cursorColor: Colors.grey,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
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
    );
  }
}
