import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.color_lens_outlined),
            title: Text("Appearance"),
            subtitle: Text("Theme settings (Not implemented yet)"),
            // onTap: () { /* TODO */ },
          ),
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