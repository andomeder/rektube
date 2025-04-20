import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rektube/views/screens/auth/login_screen.dart';
import 'package:rektube/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(GetMaterialApp(
    home: LoginScreen(),
    getPages: AppRoutes.routes,
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
  ));
}