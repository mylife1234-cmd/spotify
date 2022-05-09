import 'package:flutter/material.dart';
import 'package:spotify/components/home/header_buttons.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Recently Played',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          HeaderButtons()
        ],
      ),
    );
  }
}
