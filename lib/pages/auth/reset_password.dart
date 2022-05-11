import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/auth/input_field.dart';
import '../../components/auth/next_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset password',
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
                helperText: "We'll send you an email with a link",
              ),
              const SizedBox(height: 35),
              NextButton(
                label: 'Send link',
                color: (_email.isNotEmpty)
                    ? Colors.white
                    : const Color(0xff4d4d4d),
                onTap: !_email.isNotEmpty ? null : sendLink,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future sendLink() async {
    try {
      final userSignInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(_email);

      if (userSignInMethods.contains('password')) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset link sent'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('This email address is not registered using a password'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    }
  }
}
