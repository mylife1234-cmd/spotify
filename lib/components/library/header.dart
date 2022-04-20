import 'package:flutter/material.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({Key? key, this.handleAdding}) : super(key: key);

  final void Function()? handleAdding;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: const [
          CircleAvatar(
            foregroundImage: AssetImage('assets/images/avatar.png'),
            radius: 22,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Your Library',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      GestureDetector(
        onTap: handleAdding,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white54,
        ),
      ),
    ]);
  }
}
