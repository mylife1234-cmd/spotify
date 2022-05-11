import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 120, bottom: 20),
                child: Text(
                  'Check your email',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  "Please confirm your email address by clicking on the link that was included in our email. If you can't find the email, please check your spam folder.",
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                'assets/images/verification.png',
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
