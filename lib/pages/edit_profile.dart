import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spotify/pages/loading.dart';
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

  Uint8List? _image;

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final user = context.read<DataProvider>().user;

    controller.text = user.name;

    if (_loading) {
      return const LoadingScreen();
    }

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
              onPressed: () async {
                if (controller.text != user.name) {
                  FirebaseAuth.instance.currentUser!
                      .updateDisplayName(controller.text);
                }

                if (_image != null) {
                  final ref = FirebaseStorage.instance.ref('user');

                  setState(() {
                    _loading = true;
                  });

                  final list = await ref.listAll();

                  if (list.items.any((e) => e.name == '${user.id}.jpg')) {
                    await ref.child('${user.id}.jpg').delete();
                  }

                  final metadata = SettableMetadata(contentType: 'image/jpeg');

                  await ref.child('${user.id}.jpg').putData(_image!, metadata);

                  final url =
                      await ref.child('${user.id}.jpg').getDownloadURL();

                  context.read<DataProvider>().updateUserAvatar(url);

                  FirebaseAuth.instance.currentUser!.updatePhotoURL(url);

                  setState(() {
                    _loading = false;
                  });
                  Navigator.pop(context);
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
                        ? MemoryImage(_image!)
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
                    final bytes = await image!.readAsBytes();
                    setState(() {
                      _image = bytes;
                    });
                  },
                  child: const Text(
                    'Change photo',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
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
