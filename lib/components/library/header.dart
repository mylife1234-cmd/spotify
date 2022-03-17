import 'package:flutter/material.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: const [
          CircleAvatar(
            foregroundImage: AssetImage(
                'assets/images/avatar.png'),
            radius: 22,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Your Library',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      GestureDetector(
        onTap: () {},
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white54,
        ),
      ),
    ]);
  }
}
