import 'package:flutter/material.dart';
import 'package:spotify/components/library/filter_button.dart';
import 'package:spotify/components/library/header.dart';
import 'package:spotify/components/library/view_mode.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final filterOptions = ['Playlists', 'Artists', 'Albums'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LibraryHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: filterOptions
                        .map((option) => FilterButton(title: option))
                        .toList(),
                  ),
                ),
                const ViewModeSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
