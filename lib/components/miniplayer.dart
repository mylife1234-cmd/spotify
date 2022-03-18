import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xff2f2215)),
      child: ListTile(
        title: const Text(
          'Cảm ơn',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: const Text('Đen, Biên'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            'assets/images/cam-on.jpg',
          ),
        ),
        trailing: GestureDetector(
          child: const Icon(
            Icons.play_arrow,
            size: 28,
          ),
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
        horizontalTitleGap: 12,
        visualDensity: VisualDensity.compact,
        minVerticalPadding: 12,
      ),
    );
  }
}
