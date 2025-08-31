import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff013567);
const kSecondaryColor = Color(0xff00FFFF);

const kOnPrimary = Colors.white;
const kPrimary1Color = Color(0xff013567);
const kSecondary1Color = Color(0xff12C2E8);
const kTextFeildColor = Color(0xff777777);
ColorScheme getLightColorScheme() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    secondary: kSecondaryColor,
    onSecondary: kPrimaryColor,
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromARGB(255, 255, 255, 255),
    shadow: kPrimaryColor,
    // onSurface: kSecondaryColor,.
    onSurface: kPrimary1Color,
  );
}

ColorScheme getDarkColorScheme() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    secondary: kSecondaryColor,
    onSecondary: kPrimaryColor,
    error: Colors.red,
    onError: Colors.white,
    surface: kPrimaryColor,
    surfaceTint: kOnPrimary,
    shadow: kOnPrimary,
    onSurface: Colors.white,
  );
}
