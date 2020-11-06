import 'package:flutter/material.dart';

class GreenHouseColors {
  static const green = Color(0xff095F00);
  static const orange = Color(0xffFF792D);
  static const black = Color(0xff575756);
  static const blue = Color(0xff0069b4);
}

class GreenHouseTheme {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    primaryColor: GreenHouseColors.green,   // depricated
    accentColor: GreenHouseColors.orange,   // depricated
    disabledColor: GreenHouseColors.black,
    colorScheme: ColorScheme.light().copyWith(
      primary: GreenHouseColors.green,
      secondary: GreenHouseColors.orange,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: GreenHouseColors.orange,
      foregroundColor: Colors.white,      
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    )
  );
}
