import 'package:flutter/material.dart';
import 'package:github_profile_viewer/utils/constants.dart';

class MyThemes {
  final _myColors = MyColors();
  final MySizes _mySizes = MySizes();
  late ThemeData lightTheme;

  MyThemes() {
    lightTheme = ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: _myColors.white2,
        colorScheme: ColorScheme.light(
            primary: _myColors.grey2,
            secondary: _myColors.grey1,
            surface: _myColors.white2),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_mySizes.kDefaultPadding)),
            color: _myColors.white1,
            elevation: _mySizes.kDefaultPadding / 2),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: _myColors.yellowAccent),
        appBarTheme: const AppBarTheme(elevation: 0));
  }
}
