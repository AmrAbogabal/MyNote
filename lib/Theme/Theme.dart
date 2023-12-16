import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    fontFamily: "Licorice",
    secondaryHeaderColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Color.fromRGBO(71, 69, 69, 1),
    colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Colors.black38,
      secondary: Colors.black38 ,
    ),
    cardColor: Colors.black,
    bottomSheetTheme:BottomSheetThemeData(
      backgroundColor: Colors.black,

    ),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.red
    )

  );

  static final lightTheme = ThemeData(
    fontFamily: "Licorice",
    secondaryHeaderColor: Colors.black,
    cardColor: Color(0xfff5c37d),
    scaffoldBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
    primaryColor: Color.fromRGBO(255, 255, 255,1),
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.white70,
      secondary: Colors.white70 ,
    ),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white70
    ),
  );
}