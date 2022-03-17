import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title, style: const TextStyle(fontSize: 12),),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        border: Border.all(width: 1.5, color: Colors.white54),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
    );
  }
}
