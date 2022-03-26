import 'package:flutter/cupertino.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.color,
    this.borderColor,
    this.margin,
    this.leadingIcon,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final Color color;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final Widget? leadingIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: color,
          border: Border.all(color: borderColor ?? color, width: 0.75),
        ),
        width: size.width * 0.8,
        height: 55,
        margin: margin ?? const EdgeInsets.only(bottom: 15),
        child: Stack(
          children: [
            leadingIcon ?? const SizedBox(width: 0),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
