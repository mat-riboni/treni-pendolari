import 'package:flutter/material.dart';

class HomeTextInput extends StatelessWidget {
  const HomeTextInput({
    super.key,
    this.top,
    this.bottomLeft,
    this.bottomRight,
    required this.hint,
    this.controller,
    this.icon,
  });

  final double? top;
  final double? bottomLeft;
  final double? bottomRight;
  final String hint;
  final TextEditingController? controller;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hint,
        hintStyle: const TextStyle(fontWeight: FontWeight.w600),
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(top ?? 0),
            topLeft: Radius.circular(top ?? 0),
            bottomLeft: Radius.circular(bottomLeft ?? 0),
            bottomRight: Radius.circular(bottomRight ?? 0),
          ),
          borderSide: const BorderSide(
            color: Color(0xFFD4D4D4),
            width: 0.4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(top ?? 0),
            topLeft: Radius.circular(top ?? 0),
            bottomLeft: Radius.circular(bottomLeft ?? 0),
            bottomRight: Radius.circular(bottomRight ?? 0),
          ),
          borderSide: const BorderSide(
            color: Color(0xFFD4D4D4),
            width: 0.4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(top ?? 0),
            topLeft: Radius.circular(top ?? 0),
            bottomLeft: Radius.circular(bottomLeft ?? 0),
            bottomRight: Radius.circular(bottomRight ?? 0),
          ),
          borderSide: const BorderSide(
            color: Color(0xFFD4D4D4),
            width: 0.4,
          ),
        ),
      ),
    );
  }
}
