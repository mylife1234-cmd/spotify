import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.title,
    required this.active,
  }) : super(key: key);

  final String title;

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          width: 1.5,
          color: active ? const Color(0xff57b760) : Colors.white54,
        ),
        color: active ? const Color(0xff3d9043) : Colors.black,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 20),
      child: Text(title, style: const TextStyle(fontSize: 12)),
    );
  }
}
