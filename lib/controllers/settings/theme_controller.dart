import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';


  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode(); 
  }

  void _loadThemeMode() {
    final isDarkMode = _box.read(_key) ?? false;
    _themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(_themeMode.value);
    print("Theme loaded: ${themeMode.toString()}");
  }


  Future<void> _saveThemeMode(bool isDarkMode) async {
    await _box.write(_key, isDarkMode);
    _themeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(_themeMode.value);
    update(); 
     print("Theme saved: ${themeMode.toString()}");
  }

  void toggleTheme() {
    final bool isCurrentlyDark = _themeMode.value == ThemeMode.dark;
    _saveThemeMode(!isCurrentlyDark);
  }

   void setThemeMode(ThemeMode mode) {
      _saveThemeMode(mode == ThemeMode.dark);
   }
}