import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

Widget myTextField({
  String? hintText,
  required controller,
  IconData? prefixIcon,
  IconData? suffixIcon,
  bool obscureText = false,
  VoidCallback? suffixIcontap,
  TextStyle? textstyle,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    style: TextStyle(color: colorOnPrimary),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: colorOnPrimary, fontSize: 14),
      prefixIcon:
          prefixIcon != null
              ? Icon(prefixIcon, color: colorPrimary)
              : Icon(Icons.person, color: colorPrimary),
      suffixIcon:
          suffixIcon != null
              ? IconButton(
                onPressed: suffixIcontap,
                icon: Icon(suffixIcon, color: colorPrimary),
              )
              : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorPrimary),
      ),
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorPrimary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorPrimary),
      ),
    ),
  );
}
