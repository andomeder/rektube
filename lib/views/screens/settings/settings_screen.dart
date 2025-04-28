import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rektube/controllers/auth/auth_controller.dart';
import 'package:rektube/controllers/settings/theme_controller.dart';

final packageInfoProvider = FutureProvider<PackageInfo>((ref) async {
  return await PackageInfo.fromPlatform();
});

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeController themeController = Get.find<ThemeController>();
    final authState = ref.watch(authControllerProvider);
    final currentUser = authState.valueOrNull;
    final packageInfoAsync = ref.watch(packageInfoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          Obx(
            () => SwitchListTile(
              secondary: const Icon(Icons.color_lens_outlined),
              title: Text("Dark Mode"),
              value: themeController.themeMode == ThemeMode.dark,
              onChanged: (isDark) {
                themeController.toggleTheme();
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text("User Info"),
            subtitle:
                currentUser != null
                    ? Text(
                      "Logged in as ${currentUser.username} (${currentUser.email})",
                    )
                    : const Text("Not logged in"),
          ),

          const Divider(),
          const ListTile(
            title: Text("About"),
            dense: true,
          ),
          packageInfoAsync.when(
            data:
                (info) => ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text("App Version"),
                  subtitle: Text(
                    "${info.appName} v${info.version} (${info.buildNumber})",
                  ),
                ),
            loading:
                () => const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text("App Version"),
                  subtitle: Text("Loading..."),
                ),
            error:
                (e, s) => const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text("App Version"),
                  subtitle: Text("Error loading version"),
                ),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text("Licenses"),
            onTap:
                () => showLicensePage(
                  context: context,
                ),
          ),
        ],
      ),
    );
  }
}
