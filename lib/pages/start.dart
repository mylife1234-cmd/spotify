import 'package:flutter/material.dart';
import 'package:spotify/components/auth/login_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset('assets/images/white-logo.png', width: 60),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Millions of Songs.',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Free on Spotify.',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const LoginButton(
                    text: 'Sign up free',
                    color: Color(0xff1ed760),
                    textColor: Colors.black,
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
                  ),
                  LoginButton(
                    text: 'Continue with Facebook',
                    color: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.white,
                    leadingIcon: Positioned(
                      top: 13,
                      left: 12,
                      child: Image.asset(
                        'assets/images/brands/facebook.png',
                        width: 26,
                      ),
                    ),
                  ),
                  LoginButton(
                    text: 'Continue with Apple',
                    color: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.white,
                    margin: const EdgeInsets.only(bottom: 5),
                    leadingIcon: Positioned(
                      top: 11,
                      left: 15,
                      child: Image.asset(
                        'assets/images/brands/apple.png',
                        width: 22,
                      ),
                    ),
                  ),
                  const LoginButton(
                    text: 'Log in',
                    color: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.black,
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
