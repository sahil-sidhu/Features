import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      // Border when unselected
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        // border when selected
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

        // Hint text
        hintText: hintText,
        filled: true,
      ),
    );
  }
}
