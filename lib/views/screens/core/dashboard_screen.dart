import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/utils/routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text("Rektube", style: TextStyle(color: colorOnPrimary),),
        backgroundColor: colorBackground,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: () async {
              print("Logout tapped");
              Get.offAndToNamed(AppRoutes.login);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo-no-background.png', height: 100),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Home",
                style: TextStyle(
                  color: colorPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}