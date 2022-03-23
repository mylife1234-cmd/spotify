import 'package:flutter/cupertino.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(CupertinoIcons.forward_end_fill, size: size),
      onTap: () {},
    );
  }
}
