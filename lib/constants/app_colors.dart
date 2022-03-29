/*
    Created by Shitab Mir on 18 October 2021
 */

import 'package:flutter/material.dart';

class AppColors {
  static AppColors instance = AppColors();

  //StatusBar
  Color get statusBarColor => const Color(0xFFC88719);

  //AppBar
  Color get appBarColor => const Color(0xFFFAFAFA);
  Color get appBarTextColor => const Color(0xFF424242);
  Color get appBarIconColor => const Color(0xFF424242);

  //Others
  Color get pageBackgroundColor => const Color(0xFFFAFAFA);

  /// Colors By Name
  Color get geebung => const Color(0xFFC88719);
  Color get texasRose => const Color(0xFFFFB74D);
  Color get kournikova => const Color(0xFFffe97d);
  Color get linen => const Color(0xFFFAF3E8);

  Color get mountainMeadow => const Color(0xFF13C39C);
  Color get applegreen => const Color(0xFFE3F4F0);
  Color get silverChalice => const Color(0xFFAAAAAA);
  Color get tundora => const Color(0xFF424242);
  Color get doveGrey => const Color(0xFF666666);
  Color get sunsetOrange => const Color(0xFFFB4B4B);

  //input field related
  Color get textFieldLabelColor => const Color(0xFF3E721D);
  Color get textFieldHintColor => const Color(0xFFAAAAAA);
  Color get textFieldErrorHintColor => const Color(0xFFC73434);
  Color get textFieldBorderColor => const Color(0xFF424242);
  Color get textFieldErrorBorderColor => const Color(0xFFC73434);


  //sample get color from hex code
  // Color get testColor => HexColor("#00b2d6");
}

class HexColor extends Color {
  static int getColorFromHex(String hexColorString) {
    var hexColor = hexColorString;
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(String hexColor) : super(getColorFromHex(hexColor));
}