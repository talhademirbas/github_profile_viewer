import 'dart:io';
import 'package:dio/dio.dart';
import 'package:github_profile_viewer/utils/exceptions.dart';
import 'package:github_profile_viewer/service/model/repos_model.dart';
import 'package:github_profile_viewer/service/model/user_model.dart';
import 'package:github_profile_viewer/service/service_base.dart';

class GetService implements ServiceBase {
  final Dio _dio;

  GetService()
      : _dio = Dio(BaseOptions(baseUrl: "https://api.github.com/users/"));

  @override
  Future<UserModel?> fetchUserItems(String username) async {
    try {
      final response = await _dio.get(username);

      if (response.statusCode == HttpStatus.ok) {
        UserModel? _userModel;
        _userModel = UserModel.fromJson(response.data);
        return _userModel;
      }
    } on DioError catch (e) {
      throw CustomException(e);
    }
    return null;
  }

  @override
  Future<List<ReposModel>?> fetchRepoItems(String username) async {
    try {
      final response = await _dio.get("$username/repos");

      if (response.statusCode == HttpStatus.ok) {
        final _data = response.data;

        if (_data is List) {
          List<ReposModel>? _repoList;
          _repoList = _data.map((e) => ReposModel.fromJson(e)).toList();
          return _repoList;
        }
      }
    } on DioError catch (e) {
      throw CustomException(e);
    }
    return null;
  }
}
