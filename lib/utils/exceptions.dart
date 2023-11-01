import 'dart:io';
import 'package:dio/dio.dart';

class CustomException implements Exception {
  final DioException _error;
  final String _forbidden = "Sorry, we cant access to service";
  final String _notFound = "Sorry, we couldnt find this user";
  final String _noInternetException =
      "SocketException: Failed host lookup: 'api.github.com' (OS Error: No address associated with hostname, errno = 7)";
  final String _noInternet = "No internet connection";

  CustomException(this._error) {
    if (_error.response?.statusCode == HttpStatus.forbidden) {
      throw (_forbidden);
    } else if (_error.response?.statusCode == HttpStatus.notFound) {
      throw (_notFound);
    } else if (_error.message == _noInternetException) {
      throw (_noInternet);
    }
  }
}
