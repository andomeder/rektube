import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';

class LoginController extends GetxController {
  var errorMessage = "".obs;
  setErrorMessage(newErrorMessage) {
    errorMessage.value = newErrorMessage;
  }

  bool validateLogin(String username, String password) {
  if (username.isEmpty && password.isEmpty) {
    _showErrorSnackbar("Error", "Please enter username and password");
    return false;
  }
  if (username.isEmpty) {
    _showErrorSnackbar("Error", "Please enter username");
    return false;
  }
  if (password.isEmpty) {
    _showErrorSnackbar("Error", "Please enter password");
    return false;
  }
  return true;    
  }

  void showSuccessSnackbar(String title, String message) {
    Get.snackbar(title, message,
      backgroundColor: Colors.blue,
      snackPosition: SnackPosition.BOTTOM,
      colorText: extraColor,
      margin: EdgeInsets.all(10),
      borderRadius: 8,
    );
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(title, message,
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
      colorText: extraColor,
      margin: EdgeInsets.all(10),
      borderRadius: 8,
    );
  }

}