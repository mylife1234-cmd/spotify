import 'dart:io';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: Platform.isIOS
          ? (details) {
              if (details.primaryVelocity! > 0) pop();
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
              child: const BackButtonIcon(),
              onTap: pop,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  InputField(
                    controller: _controller,
                    label: options[_currentOption]['label']!,
                    onChanged: (value) => setState(() {
                      results[options[_currentOption]['name']!] = value;
                    }),
                    helperText: options[_currentOption]['helper'],
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
                              print(results);
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

  pop() {
    if (_currentOption == 0) {
      Navigator.pop(context);
    } else {
      _controller.text = results.values.elementAt(_currentOption - 1);
      setState(() {
        _currentOption--;
      });
    }
  }
}
