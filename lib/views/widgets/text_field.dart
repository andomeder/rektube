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
    style: TextStyle(color: extraColor),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: extraColor, fontSize: 14),
      prefixIcon:
          prefixIcon != null
              ? Icon(prefixIcon, color: secondaryColor)
              : Icon(Icons.person, color: secondaryColor),
      suffixIcon:
          suffixIcon != null
              ? IconButton(
                onPressed: suffixIcontap,
                icon: Icon(suffixIcon, color: secondaryColor),
              )
              : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: secondaryColor),
      ),
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: secondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: secondaryColor),
      ),
    ),
  );
}
