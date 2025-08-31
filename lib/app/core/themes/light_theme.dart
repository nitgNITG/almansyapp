import 'package:step/app/core/themes/colors.dart';
import 'package:flutter/material.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: kOnPrimary,
    //getLightColorScheme().background,
    appBarTheme: const AppBarTheme(
      color: Color(0xff013567),
    ),
    colorScheme: getLightColorScheme(),
    textTheme: getLightThemeTextStyle(),
    iconTheme: IconThemeData(
      color: getLightColorScheme().onSurface,
    ),
    inputDecorationTheme: getLightInputDecoTheme(),
    scrollbarTheme: ScrollbarThemeData(
      crossAxisMargin: 5,
      mainAxisMargin: 5,
      interactive: true,
      thumbVisibility: WidgetStateProperty.resolveWith((states) => true),
      trackVisibility: WidgetStateProperty.resolveWith((states) => true),
      trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.dragged)) {
          return Colors.white.withOpacity(
            0.5,
          ); // The thumb will be red when dragged
        }
        return Colors.white.withOpacity(
          0.3,
        ); // The default thumb color
      }),
      radius: const Radius.circular(10),
      thumbColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.dragged)) {
            return kPrimaryColor; // The thumb will be red when dragged
          }
          return kPrimaryColor.withOpacity(
            0.5,
          ); // The default thumb color
        },
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getLightThemeTextStyle().displayMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: kOnPrimary,
              fontFamily: "Cairo",
            ),
        backgroundColor: Colors.cyan,
        foregroundColor: kOnPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kPrimary1Color, // Color of the cursor
      selectionColor: kPrimary1Color.withOpacity(0.5), // Color of the selection
      selectionHandleColor: kPrimary1Color, // Color of the selection handles
    ),
  );
}

InputDecorationTheme getLightInputDecoTheme() {
  return InputDecorationTheme(
    //  filled: true,
    // fillColor: getLightColorScheme().background,
    // border: InputBorder.none,
    alignLabelWithHint: true,

    /// this for it when it be Hint
    labelStyle: getLightThemeTextStyle().displayMedium!.copyWith(
          color: kPrimaryColor.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),

    /// this for it when it be Label
    floatingLabelStyle: getLightThemeTextStyle().displayMedium!.copyWith(
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffD9D9D9))),

    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: getLightColorScheme().error),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD9D9D9)),
    ),
  );
}

TextTheme getLightThemeTextStyle() {
  return TextTheme(
    bodyMedium: TextStyle(color: getLightColorScheme().onPrimary),
    displayLarge: TextStyle(
      color: getLightColorScheme().onSurface,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: "Cairo",
    ),
    displayMedium: TextStyle(
      color: getLightColorScheme().onSurface,
      fontSize: 16,
      fontFamily: "Cairo",
    ),
    displaySmall: TextStyle(
      color: getLightColorScheme().onSurface,
      fontSize: 10,
      fontFamily: "Cairo",
    ),
  );
}
