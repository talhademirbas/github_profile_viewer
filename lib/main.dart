import 'package:flutter/material.dart';
import 'package:github_profile_viewer/screens/home/home_screen.dart';
import 'package:github_profile_viewer/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String _title = 'Github Profile Viewer';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        theme: MyThemes().lightTheme,
        home: const HomeScreen());
  }
}
