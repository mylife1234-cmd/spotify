import 'package:flutter/cupertino.dart';

class AnimateLabel extends StatelessWidget {
  final bool isShow;
  final String label;
  const AnimateLabel({Key? key, required this.label, required this.isShow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isShow ? 1 : 0,
      child: Container(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Text(
          label,
          // style: Theme.of(context).textTheme.headline6,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
