import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify/components/auth/login_button.dart';
import 'package:spotify/pages/login.dart';
import 'package:spotify/pages/reset_password.dart';
import 'package:spotify/pages/sign_up.dart';
import 'package:spotify/utils/helper.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                  Colors.black
                ],
              ),
            ),
          ),
          Center(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/white-logo.png',
                      width: 60,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Millions of Songs.',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Free on Spotify.',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  LoginButton(
                    text: 'Sign up free',
                    color: const Color(0xff1ed760),
                    textColor: Colors.black,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const SignUpPage();
                        }),
                      );
                    },
                  ),
                  LoginButton(
                    text: 'Continue with Google',
                    color: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.white,
                    leadingIcon: Positioned(
                      top: 13,
                      left: 13,
                      child: Image.asset(
                        'assets/images/brands/google.png',
                        width: 26,
                      ),
                    ),
                    onTap: () async {
                      try {
                        final googleUser = await GoogleSignIn().signIn();

                        final googleAuth = await googleUser?.authentication;

                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth?.accessToken,
                          idToken: googleAuth?.idToken,
                        );

                        final userCredential = await FirebaseAuth.instance
                            .signInWithCredential(credential);

                        initUser(userCredential);
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                  ),
                  LoginButton(
                    text: 'Reset password',
                    color: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.white,
                    margin: const EdgeInsets.only(bottom: 5),
                    leadingIcon: const Positioned(
                      top: 13,
                      left: 14,
                      child: Icon(Icons.password),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const ResetPasswordPage();
                        }),
                      );
                    },
                  ),
                  LoginButton(
                    text: 'Log in',
                    color: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.black,
                    margin: const EdgeInsets.only(bottom: 20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
