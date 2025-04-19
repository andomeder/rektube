import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: colorPrimary,
  scaffoldBackgroundColor: colorBackground,
  colorScheme: const ColorScheme.dark(
    primary: colorPrimary,
    secondary: colorAccent,
    background: colorBackground,
    surface: colorBackground,
    onPrimary: colorOnBackground,
    onSecondary: colorOnBackground,
    onBackground: colorOnBackground,
    onSurface: colorOnBackground,
    error: colorError,
    onError: colorOnBackground,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: colorBackground,
    elevation: 0,
    foregroundColor: colorOnBackground,
    iconTheme: IconThemeData(color: colorOnBackground),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: colorBackground,
    selectedItemColor: colorPrimary,
    unselectedItemColor: colorHint,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed
  ),
  inputDecorationTheme: InputDecorationTheme(
     // Use your text_field styles or define globally here
     hintStyle: const TextStyle(color: colorHint, fontSize: 14),
     prefixIconColor: colorPrimary,
     suffixIconColor: colorPrimary,
     border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10),
       borderSide: const BorderSide(color: colorPrimary),
     ),
     enabledBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10),
       borderSide: const BorderSide(color: colorPrimary),
     ),
     focusedBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10),
       borderSide: const BorderSide(color: colorPrimary, width: 2.0), // Highlight focus
     ),
     errorBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10),
       borderSide: const BorderSide(color: colorError),
     ),
     focusedErrorBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10),
       borderSide: const BorderSide(color: colorError, width: 2.0),
     ),
     contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Adjust padding
  ),
   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorPrimary,
      foregroundColor: colorOnPrimary, // Text color on button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: const Size(150, 45), // Standard button size
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colorPrimary, // Text color for text buttons
    ),
  ),
   fontFamily: 'Fraunces', // Set default font
   // Add other theme properties as needed (textTheme, cardTheme, etc.)
);