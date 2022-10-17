import 'package:github_profile_viewer/service/model/repos_model.dart';
import 'package:github_profile_viewer/service/model/user_model.dart';

abstract class ServiceBase {
  Future<UserModel?> fetchUserItems(String username);

  Future<List<ReposModel>?> fetchRepoItems(String username);
}
