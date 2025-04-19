import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
void showSnackbar(String title, String message, {bool isError = false}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: isError ? colorError : colorAccent,
    snackPosition: SnackPosition.BOTTOM,
    colorText: colorOnBackground, // Use theme color
    margin: const EdgeInsets.all(10),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
  );
}