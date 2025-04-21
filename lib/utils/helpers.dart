import 'package:flutter/material.dart';
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
    return ''; // Return empty string or a placeholder URL if needed
  }

  const String internalProxyHost = 'pipedproxy.rektube'; // The hostname used internally by Piped
  const String localForwardHost = '127.0.0.1'; // Use localhost/127.0.0.1 for adb reverse
  const int localForwardPort = 3142; // The host port mapped to Caddy

  try {
    final uri = Uri.parse(originalUrl);
    // Check if the host matches the internal proxy name
    if (uri.host == internalProxyHost) {
      // Replace host and port
      final newUri = uri.replace(
        scheme: 'http', // Assuming local dev is http
        host: localForwardHost,
        port: localForwardPort,
      );
      // print("Rewriting URL: ${originalUrl} -> ${newUri.toString()}"); // Debugging
      return newUri.toString();
    }
  } catch (e) {
    print("Error parsing/rewriting URL '$originalUrl': $e");
    // Return original URL or empty string on error
    return originalUrl;
  }

  // If host doesn't match, return the original URL unchanged
  return originalUrl;
}