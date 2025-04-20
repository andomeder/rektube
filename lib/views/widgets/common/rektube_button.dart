import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

Widget rektubeButton(VoidCallback? onPressed, {required String label, bool isLoading = false}) {
  return ElevatedButton(
    onPressed: isLoading ? null : onPressed,
    child: isLoading
    ? const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: colorPrimary,
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(colorOnBackground),
      ),
    )
    : Text(label),
  );
}