import 'package:flutter/material.dart';
import 'package:spotify/components/library/header.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Column(
              children: const [
                LibraryHeader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
