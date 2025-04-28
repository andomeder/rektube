import 'package:flutter/material.dart';
import 'package:rektube/configs/colours.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: colorPrimary,
  scaffoldBackgroundColor: colorBackground,
  colorScheme: const ColorScheme.dark(
    primary: colorPrimary,
    secondary: colorAccent,
    surface: colorBackground,
    onPrimary: colorOnBackground,
    onSecondary: colorOnBackground,
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
       borderSide: const BorderSide(color: colorPrimary, width: 2.0), 
     ),
     errorBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10),
       borderSide: const BorderSide(color: colorError),
     ),
     focusedErrorBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10),
       borderSide: const BorderSide(color: colorError, width: 2.0),
     ),
     contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), 
  ),
   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorPrimary,
      foregroundColor: colorOnPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: const Size(150, 45), 
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colorPrimary,
    ),
  ),
   fontFamily: 'Fraunces',
   
);


final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightColorPrimary,
  scaffoldBackgroundColor: lightColorBackground,
  colorScheme: ColorScheme.light(
     primary: lightColorPrimary,
     secondary: colorAccent,
     surface: lightColorSurface,
     onPrimary: lightColorOnPrimary,
     onSecondary: Colors.black,
     onSurface: lightColorOnBackground, 
     error: colorError,
     onError: Colors.white,
  ),
   appBarTheme: const AppBarTheme(
     backgroundColor: lightColorSurface,
     elevation: 1,
     foregroundColor: lightColorOnBackground, 
     iconTheme: IconThemeData(color: lightColorOnBackground),
   ),
   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
     backgroundColor: lightColorSurface,
     selectedItemColor: lightColorPrimary,
     unselectedItemColor: lightColorHint,
     showUnselectedLabels: true,
     type: BottomNavigationBarType.fixed,
   ),
   inputDecorationTheme: InputDecorationTheme( 
      hintStyle: const TextStyle(color: lightColorHint, fontSize: 14),
      prefixIconColor: lightColorPrimary,
      suffixIconColor: lightColorPrimary,
      border: OutlineInputBorder( borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade400),),
      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade400),),
      focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: lightColorPrimary, width: 2.0),),
      errorBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: colorError),),
      focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: colorError, width: 2.0),),
      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
   ),
   elevatedButtonTheme: ElevatedButtonThemeData( /* TODO: Adjust style*/ ),
   textButtonTheme: TextButtonThemeData( /* TODO: Adjust style*/ ),
   fontFamily: 'Fraunces',
);