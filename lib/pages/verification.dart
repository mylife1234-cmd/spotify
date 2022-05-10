import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
            "Please confirm your email address by clicking on the link that was included in our email. If you can't find the email, please check your spam folder."),
      ),
    );
  }
}
