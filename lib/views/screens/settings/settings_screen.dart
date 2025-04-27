import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rektube/controllers/settings/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          Obx ( () => SwitchListTile(
            secondary: const Icon(Icons.color_lens_outlined),
            title: Text("Dark Mode"),
            value: themeController.themeMode == ThemeMode.dark,
            onChanged: (isDark) {
              themeController.toggleTheme();
            },
          )),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text("Account"),
            subtitle: Text("Manage your account settings (Not implemented yet)"),
            // onTap: () { /* TODO */ },
          ),
            ListTile(
             leading: Icon(Icons.info_outline),
             title: Text("About"),
              subtitle: Text("App version, licenses (Not implemented)"),
             // onTap: () { /* TODO */ },
           ),
        ],
      ),
    );
  }
}