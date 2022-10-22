import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyThemes {
  late ThemeData lightTheme;

  MyThemes() {
    lightTheme = ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: MyColors.white2,
        colorScheme: ColorScheme.light(
            primary: MyColors.grey2,
            secondary: MyColors.grey1,
            surface: MyColors.white2),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySizes.kDefaultPadding)),
            color: MyColors.white1,
            elevation: MySizes.kDefaultPadding / 2),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: MyColors.yellowAccent),
        appBarTheme: const AppBarTheme(elevation: 0));
  }
}
