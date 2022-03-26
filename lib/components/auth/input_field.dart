import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    required this.label,
    this.helperText,
    this.obscure,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final String? helperText;
  final bool? obscure;
  final void Function(String)? onChanged;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _showPassword;

  @override
  void initState() {
    super.initState();

    _showPassword = widget.obscure ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            fillColor: const Color(0xff414141),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            focusColor: const Color(0xff707070),
            suffixIcon: (widget.obscure != null && widget.obscure == true)
                ? GestureDetector(
                    child: Icon(
                      _showPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xfff9f9f9),
                    ),
                    onTap: () => setState(() {
                      _showPassword = !_showPassword;
                    }),
                  )
                : null,
            contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16)
          ),
          cursorColor: const Color(0xff57b660),
          obscureText: _showPassword,
          onChanged: widget.onChanged,
        )
      ],
    );
  }
}
