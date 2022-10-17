import 'package:flutter/material.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget({Key? key, required this.message}) : super(key: key);

  final String title = "Oops!";
  final String message;

  @override
  Widget build(BuildContext context) {
    return AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.failure,
    );
  }
}
