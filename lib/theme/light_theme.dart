import 'package:flutter/material.dart';
import 'package:github_profile_viewer/components/decorated_input_border.dart';
import '../utils/constants.dart';

class MyThemes {
  late ThemeData lightTheme;

  MyThemes() {
    lightTheme = ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: MyColors.white2,
        colorScheme: const ColorScheme.light(
          primary: MyColors.grey2,
          secondary: MyColors.grey2,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: ThemeData.light()
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w300)),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySizes.kDefaultPadding)),
            color: MyColors.white1,
            elevation: MySizes.kDefaultPadding / 2),
        inputDecorationTheme: InputDecorationTheme(
            errorStyle: ThemeData.light()
                .textTheme
                .titleSmall
                ?.copyWith(color: ThemeData.light().colorScheme.error),
            counterStyle: ThemeData.light().textTheme.bodySmall,
            filled: true,
            fillColor: MyColors.white1,
            border: DecoratedInputBorder(
              child: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.all(Radius.circular(MySizes.kDefaultPadding)),
              ),
              shadow: const BoxShadow(
                blurStyle: BlurStyle.normal,
                offset: Offset(
                  0,
                  MySizes.kSmallPadding / 2,
                ),
                spreadRadius: 0,
                blurRadius: MySizes.kSmallPadding / 2,
                color: MyColors.shadowColor,
              ),
            )),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: MyColors.yellowAccent));
  }
}
