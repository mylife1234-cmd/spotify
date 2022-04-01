import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(CupertinoIcons.chevron_back),
    );
  }
}
