import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

Widget myTextField({
  String? hintText,
  required TextEditingController controller,
  IconData? prefixIcon = Icons.person,
  IconData? suffixIcon,
  bool obscureText = false,
  VoidCallback? suffixIcontap,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  TextStyle? textstyle,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    style: textstyle ?? const TextStyle(color: colorOnBackground),
    validator: validator,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      suffixIcon: suffixIcon != null
          ? IconButton(
              onPressed: suffixIcontap,
              icon: Icon(suffixIcon, color: colorPrimary),
            )
          : null,
    ),
  );
}