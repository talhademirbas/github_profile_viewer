import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_profile_viewer/model/repos_model.dart';
import 'package:github_profile_viewer/pages/main_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ReposInfo extends StatefulWidget {
  const ReposInfo(String userneym, {Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<ReposInfo> {
  Future<Object?> _getRepos() async {
    debugPrint(userneym);
    try {
      dynamic response =
          await Dio().get('https://api.github.com/users/$userneym/repos');
      List<ReposModel?> _repoList;
      if (response.statusCode == 200) {
        _repoList =
            (response.data as List).map((e) => ReposModel.fromMap(e)).toList();
        return _repoList;
      }
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getRepos(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            List<ReposModel?> rrepos = snapshot.data! as List<ReposModel?>;
            return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ReposModel? relement = rrepos[index];
                  return Card(
                    color: Colors.deepOrange,
                    elevation: 5,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CircleAvatar(
                          child: Text(
                            relement!.language == null
                                ? ' '
                                : relement.language.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepOrange,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Text(
                            relement.name == null
                                ? ' '
                                : relement.name.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 18)),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                            relement.description == null
                                ? ' '
                                : relement.description.toString(),
                            style: const TextStyle(
                                color: Colors.black87,
                                fontFamily: 'RobotoMono',
                                fontSize: 14)),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                      onTap: () async {
                        var url = relement.htmlUrl;
                        await launch(url);
                      },
                    ),
                  );
                },
                itemCount: rrepos.length);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString() + ' :D');
          } else {
            return const SizedBox();
          }
        });
  }
}
