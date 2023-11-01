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
        UserModel? userModel;
        userModel = UserModel.fromJson(response.data);
        return userModel;
      }
    } on DioException catch (e) {
      throw CustomException(e);
    }
    return null;
  }

  @override
  Future<List<ReposModel>?> fetchRepoItems(String username) async {
    try {
      final response = await _dio.get("$username/repos");

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;

        if (data is List) {
          List<ReposModel>? repoList;
          repoList = data.map((e) => ReposModel.fromJson(e)).toList();
          return repoList;
        }
      }
    } on DioException catch (e) {
      throw CustomException(e);
    }
    return null;
  }
}
