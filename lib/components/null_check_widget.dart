import 'package:flutter/material.dart';
import 'package:github_profile_viewer/utils/constants.dart';

class NullCheck extends StatelessWidget {
  const NullCheck(
      {this.text,
      this.text2,
      this.textStyle,
      this.textStyle2,
      this.icon,
      this.icon2,
      this.parameter1,
      this.parameter2,
      Key? key})
      : super(key: key);

  final String? text;
  final String? text2;
  final String? parameter1;
  final String? parameter2;
  final Widget? icon;
  final Widget? icon2;
  final TextStyle? textStyle;
  final TextStyle? textStyle2;

  @override
  Widget build(BuildContext context) {
    //Ex: UserCard's followers and following row
    if (text != null &&
        text2 != null &&
        icon != null &&
        icon2 != null &&
        parameter1 != null &&
        parameter2 != null) {
      return Row(
        children: [
          Row(
            children: [
              icon!,
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Row(
                  children: [
                    Text(
                      "$text ",
                      style: textStyle ?? const TextStyle(),
                    ),
                    Text(
                      "$parameter1",
                      style: textStyle2 ?? const TextStyle(),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:4.0),
            child: Row(
              children: [
                icon2!,
                Padding(
                  padding: const EdgeInsets.only(left:4.0),
                  child: Row(
                    children: [
                      Text(
                        "$text2 ",
                        style: textStyle ?? const TextStyle(),
                      ),
                      Text(
                        "$parameter2",
                        style: textStyle2 ?? const TextStyle(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    }
    //Ex: RepoCard's stargazer and language row
    else if (text != null && text2 != null && icon != null && icon2 != null) {
      return Row(
        children: [
          Row(
            children: [
              icon!,
              Padding(
                padding: EdgeInsets.only(left: MySizes.kSmallPadding / 2),
                child: Text(
                  "$text",
                  style: textStyle ?? const TextStyle(),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: MySizes.kSmallPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon2!,
                Padding(
                  padding: EdgeInsets.only(left: MySizes.kSmallPadding / 2),
                  child: Text(
                    "$text2",
                    style: textStyle ?? const TextStyle(),
                  ),
                )
              ],
            ),
          )
        ],
      );

      //Icon And Text Row
    } else if (icon != null && text != null) {
      if (text!.isNotEmpty) {
        return Row(children: [
          icon!,
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(
              "$text",
              style: textStyle ?? const TextStyle(),
            ),
          )
        ]);
      } else {
        return const SizedBox.shrink();
      }
    }
    //Only Text Row
    else if (text != null) {
      if (text!.isNotEmpty) {
        return Text(
          "$text",
          style: textStyle ?? const TextStyle(),
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
