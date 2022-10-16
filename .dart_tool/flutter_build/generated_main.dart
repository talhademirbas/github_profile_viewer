//
// Generated file. Do not edit.
// This file is generated from template in file `flutter_tools/lib/src/flutter_plugins.dart`.
//

// @dart = 2.15

// When `package:github_profile_viewer/main.dart` defines `main`, that definition is shadowed by the definition below.
export 'package:github_profile_viewer/main.dart';

import 'package:github_profile_viewer/main.dart' as entrypoint;
import 'dart:io'; // flutter_ignore: dart_io_import.
import 'package:url_launcher_android/url_launcher_android.dart';
import 'package:url_launcher_ios/url_launcher_ios.dart';
import 'package:url_launcher_linux/url_launcher_linux.dart';
import 'package:url_launcher_macos/url_launcher_macos.dart';
import 'package:url_launcher_windows/url_launcher_windows.dart';

@pragma('vm:entry-point')
class _PluginRegistrant {

  @pragma('vm:entry-point')
  static void register() {
    if (Platform.isAndroid) {
      try {
        UrlLauncherAndroid.registerWith();
      } catch (err) {
        print(
          '`url_launcher_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isIOS) {
      try {
        UrlLauncherIOS.registerWith();
      } catch (err) {
        print(
          '`url_launcher_ios` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isLinux) {
      try {
        UrlLauncherLinux.registerWith();
      } catch (err) {
        print(
          '`url_launcher_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isMacOS) {
      try {
        UrlLauncherMacOS.registerWith();
      } catch (err) {
        print(
          '`url_launcher_macos` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isWindows) {
      try {
        UrlLauncherWindows.registerWith();
      } catch (err) {
        print(
          '`url_launcher_windows` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    }
  }

}

typedef _UnaryFunction = dynamic Function(List<String> args);
typedef _NullaryFunction = dynamic Function();

void main(List<String> args) {
  if (entrypoint.main is _UnaryFunction) {
    (entrypoint.main as _UnaryFunction)(args);
  } else {
    (entrypoint.main as _NullaryFunction)();
  }
}
