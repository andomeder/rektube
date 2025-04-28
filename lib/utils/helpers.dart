import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:rektube/configs/colours.dart';
void showSnackbar(String title, String message, {bool isError = false}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: isError ? colorError : colorAccent,
    snackPosition: SnackPosition.BOTTOM,
    colorText: colorOnBackground, // Use theme color
    margin: const EdgeInsets.all(10),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
  );
}

String rewritePipedUrlForLocalDev(String? originalUrl) {
  if (originalUrl == null) {
    return '';
  }

  const String internalProxyHost = 'pipedproxy.rektube'; 


  String ngrokHost = dotenv.env['NGROK_HOST']!; 
  const int ngrokPort = 443; 


  //const String localForwardHost = '127.0.0.1';
  //const int localForwardPort = 3142; 

  try {
    final uri = Uri.parse(originalUrl);
    if (uri.host == internalProxyHost) {
      // Replace host and port
      final newUri = uri.replace(
        scheme: 'https', 
        //host: localForwardHost,
        host: ngrokHost,
        //port: localForwardPort,
        port: ngrokPort,
      );
      // print("Rewriting URL: ${originalUrl} -> ${newUri.toString()}"); // Debugging
      return newUri.toString();
    }
  } catch (e) {
    print("Error parsing/rewriting URL '$originalUrl': $e");
    return originalUrl;
  }

  return originalUrl;
}