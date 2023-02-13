import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 230, 49, 76);
  //static const Color iconsColor = Color.fromARGB(255, 8, 49, 185);
  static const Color BGcolor = Color.fromARGB(255, 255, 255, 255);

  static final mainTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      elevation: 1
    ),
    scaffoldBackgroundColor: BGcolor,

    listTileTheme: ListTileThemeData(
      selectedColor: Colors.grey,
      contentPadding: EdgeInsets.all(20),
    ),

    iconTheme: IconThemeData(
      color: primary
    )
  );
}
