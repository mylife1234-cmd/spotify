import 'package:flutter/material.dart';

import '../../pages/search_all.dart';

class SearchField extends StatelessWidget {
  SearchField({Key? key}) : super(key: key);

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        focusNode: _focusNode,
        onTap: () {
          _focusNode.unfocus();
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, a1, a2) {
                return const SearchAll();
              },
              transitionsBuilder: (context, a1, a2, child) {
                return FadeTransition(opacity: a1, child: child);
              },
              transitionDuration: const Duration(milliseconds: 175),
              reverseTransitionDuration: const Duration(milliseconds: 125),
            ),
          );
        },
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Search for something',
          hintStyle: const TextStyle(color: Colors.black),
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          contentPadding: EdgeInsets.zero,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
