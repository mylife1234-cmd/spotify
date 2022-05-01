import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify/components/auth/input_field.dart';
import 'package:spotify/components/auth/next_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              InputField(
                label: 'Email',
                onChanged: (value) => setState(() {
                  _email = value;
                }),
              ),
              const SizedBox(height: 25),
              InputField(
                label: 'Password',
                obscure: true,
                onChanged: (value) => setState(() {
                  _password = value;
                }),
              ),
              const SizedBox(height: 50),
              NextButton(
                label: 'Log in',
                color: (_email.isNotEmpty && _password.isNotEmpty)
                    ? Colors.white
                    : const Color(0xff4d4d4d),
                onTap:
                    !(_email.isNotEmpty && _password.isNotEmpty) ? null : login,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }
}
