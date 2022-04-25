import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify/models/user.dart' as model;
import 'package:spotify/utils/firebase/db.dart';

import '../components/auth/input_field.dart';
import '../components/auth/next_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _controller = TextEditingController();

  Map<String, String> results = {};

  int _currentOption = 0;

  final options = [
    {
      'name': 'email',
      'label': 'What’s your email?',
      'helper': 'You’ll need to confirm this email later.'
    },
    {
      'name': 'password',
      'label': 'Create a password',
      'helper': 'Use at least 8 characters.'
    },
    {
      'name': 'name',
      'label': 'What’s your name?',
      'helper': 'This appears on your spotify profile.'
    }
  ];

  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: Platform.isIOS
          ? (details) {
              if (details.primaryVelocity! > 0) {
                pop();
              }
            }
          : null,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Create account',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            backgroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: pop,
              child: const BackButtonIcon(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  CarouselSlider(
                    items: options.map((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InputField(
                          controller: _controller,
                          label: option['label']!,
                          onChanged: (value) => setState(() {
                            results[option['name']!] = value;
                          }),
                          helperText: option['helper'],
                          obscure: option['name'] == 'password',
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 110,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                    ),
                    carouselController: carouselController,
                  ),
                  const SizedBox(height: 50),
                  NextButton(
                    label: _currentOption < options.length - 1
                        ? 'Next'
                        : 'Create an account',
                    color: (results.length >= _currentOption + 1 &&
                            results.values.elementAt(_currentOption).isNotEmpty)
                        ? Colors.white
                        : const Color(0xff4d4d4d),
                    onTap: !(results.length >= _currentOption + 1 &&
                            results.values.elementAt(_currentOption).isNotEmpty)
                        ? null
                        : () {
                            if (_currentOption < options.length - 1) {
                              carouselController.nextPage();

                              if (results.length - 1 >= _currentOption + 1 &&
                                  results.values
                                      .elementAt(_currentOption + 1)
                                      .isNotEmpty) {
                                _controller.text = results.values
                                    .elementAt(_currentOption + 1);
                              } else {
                                _controller.text = '';
                              }

                              setState(() {
                                _currentOption++;
                              });
                            } else {
                              debugPrint(results.toString());
                              signUp();
                            }
                          },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pop() {
    if (_currentOption == 0) {
      Navigator.pop(context);
    } else {
      _controller.text = results.values.elementAt(_currentOption - 1);
      setState(() {
        _currentOption--;
      });

      carouselController.previousPage();

      FocusScope.of(context).unfocus();
    }
  }

  Future signUp() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: results['email']!,
        password: results['password']!,
      );

      credential.user!.updateDisplayName(results['name']!);

      initUser(credential);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> initUser(UserCredential credential) async {
    final playlistIdList = await Database.getPlaylistIdList();

    playlistIdList.shuffle();

    final user = model.User(
      id: credential.user!.uid,
      name: credential.user!.displayName!,
      coverImageUrl: credential.user!.photoURL!,
      recentAlbumIdList: [],
      favoriteAlbumIdList: [],
      recentPlaylistIdList: [],
      favoritePlaylistIdList: [],
      recentSongIdList: [],
      favoriteSongIdList: [],
      customizedPlaylistIdList: [],
      systemPlaylistIdList: playlistIdList.sublist(0, 5),
    );

    Database.setUser(user);
  }
}
