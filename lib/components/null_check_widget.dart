import 'package:flutter/material.dart';

class NullCheck extends StatelessWidget {
  const NullCheck(
      {this.text,
      this.text2,
      this.textStyle,
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
  final Icon? icon;
  final Icon? icon2;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    //Two Row With Both Icon And Text
    if (text != null && text2 != null && icon != null && icon2 != null) {
      return Row(
        children: [
          Row(
            children: [
              icon!,
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "$text ${parameter1 ?? ""}",
                  style: textStyle ?? const TextStyle(),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              children: [
                icon2!,
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "$text2 ${parameter2 ?? ""}",
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
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "$text ${parameter1 ?? ""}",
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
          "$text ${parameter1 ?? ""}",
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
