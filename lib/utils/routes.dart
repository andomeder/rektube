import 'package:get/get.dart';
import 'package:rektube/views/screens/auth/login.dart';

class AppRoutes {
  static const String login = "/";
  static const String signup = "/signup";
  static const String home = "/home";


  static List<GetPage> routes = [
    GetPage(name: login, page: () => Login()),
  ];
}