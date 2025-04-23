import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/utils/routes.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text("Rektube"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: "Account Settings",
            onPressed: () {
              // TODO: Implement Settings Popup Menu (Phase 7)
              Get.snackbar("Info", "Settings menu not implemented yet.");
            },
            icon: const Icon(Icons.account_circle_rounded),
          ),
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: () async {
              print("Logout tapped");
              //Get.offAndToNamed(AppRoutes.login);
              await ref.read(authControllerProvider.notifier).manualLogout();
            },
          ),
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
            Container(
              width: 150.0,
              height: 80.0,
              color: Colors.blue, // Or use decoration: BoxDecoration(...)
              alignment:
                  Alignment
                      .center, // Alternative to using Center widget as child
              child: Text(
                'Users \n 150',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
