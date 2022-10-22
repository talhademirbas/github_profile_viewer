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
          secondary: MyColors.grey2,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: ThemeData.light()
                .textTheme
                .headline6
                ?.copyWith(color: MyColors.grey2),
            bodyText2: ThemeData.light().textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w300, fontSize: MySizes.kDefaultFont)),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySizes.kDefaultPadding)),
            color: MyColors.white1,
            elevation: MySizes.kDefaultPadding / 2),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(
              horizontal: MySizes.kDefaultPadding,
              vertical: MySizes.kDefaultIcon),
          errorStyle: ThemeData.light()
              .textTheme
              .subtitle2
              ?.copyWith(color: ThemeData.light().errorColor),
          counterStyle: ThemeData.light().textTheme.caption,
          filled: true,
          fillColor: MyColors.white1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MySizes.kDefaultPadding),
          ),
        ),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: MyColors.yellowAccent),
        appBarTheme: const AppBarTheme(elevation: 0));
  }
}
