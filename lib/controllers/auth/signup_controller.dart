import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rektube/configs/colours.dart';

class SignUpController extends GetxController {
  bool validateSignup(String firstName, String lastName, String username,
      String email, String password, String confirmPassword) {
        if (firstName.isEmpty && lastName.isEmpty && username.isEmpty &&
            email.isEmpty && password.isEmpty && confirmPassword.isEmpty) {
          _showErrorSnackbar("Error", "Please enter all fields");
          return false;
        }
        if (firstName.isEmpty) {
          _showErrorSnackbar("Error", "Please enter first name");
          return false;
        }
        if (lastName.isEmpty) {
          _showErrorSnackbar("Error", "Please enter last name");
          return false;
        }
        if (username.isEmpty) {
          _showErrorSnackbar("Error", "Please enter username");
          return false;
        }
        if (email.isEmpty) {
          _showErrorSnackbar("Error", "Please enter email");
          return false;
        }
        if (!email.contains('@') || !email.contains(".")) {
          _showErrorSnackbar(
              "Validation Error", "Please enter a valid email address.");
          return false;
        }

        if (password.isEmpty) {
          _showErrorSnackbar("Error", "Please enter password");
          return false;
        }
        if (confirmPassword.isEmpty) {
          _showErrorSnackbar("Error", "Please confirm password");
          return false;
        }
        if (password != confirmPassword) {
          _showErrorSnackbar("Error", "Passwords do not match");
          return false;
        }
        return true;
      }

      void _showErrorSnackbar(String title, String message) {
        Get.snackbar(title, message,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM,
            colorText: extraColor,
            margin: EdgeInsets.all(10),
            borderRadius: 8); 
      }
}