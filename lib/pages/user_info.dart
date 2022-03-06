import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_profile_viewer/constants.dart';
import 'package:github_profile_viewer/model/user_model.dart';
import 'package:github_profile_viewer/pages/main_page.dart';

class UserInfo extends StatefulWidget {
  const UserInfo(String userneym, {Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<UserInfo> {
  Future<Object?> _getUser() async {
    try {
      var response = await Dio().get('https://api.github.com/users/$userneym');
      UserModel? _user;
      if (response.statusCode == 200) {
        _user = UserModel.fromMap(response.data);
      }
      return _user;
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
        future: _getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            UserModel? uuser = snapshot.data as UserModel?;
            return Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(
                      color: Colors.black12, style: BorderStyle.solid),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundImage:
                            NetworkImage(uuser!.avatarUrl.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(uuser.name.toString(),
                            style: const TextStyle(
                                fontFamily: 'Roboto', fontSize: 15.0)),
                      ),
                      Text(uuser.login.toString(),
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LimitedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            uuser.bio != null
                                ? Row(
                                    children: [
                                      const Icon(Icons.edit),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(uuser.bio.toString(),
                                            style: sideuserinfo),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            uuser.location != null
                                ? Row(
                                    children: [
                                      const Icon(Icons.location_on),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(uuser.location.toString(),
                                            style: sideuserinfo),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            uuser.company != null
                                ? Row(
                                    children: [
                                      const Icon(Icons.work_rounded),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(uuser.company.toString(),
                                            style: sideuserinfo),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            uuser.email != null
                                ? Row(
                                    children: [
                                      const Icon(Icons.mail),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(uuser.email.toString(),
                                            style: sideuserinfo),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            uuser.blog != ""
                                ? Row(
                                    children: [
                                      const Icon(Icons.web_outlined),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(uuser.blog.toString(),
                                            style: sideuserinfo),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Followers:" + uuser.followers.toString(),
                                style: const TextStyle(
                                    fontFamily: 'RobotoMono', fontSize: 14.0)),
                            const SizedBox(width: 8),
                            Text("Following:" + uuser.following.toString(),
                                style: const TextStyle(
                                    fontFamily: 'RobotoMono', fontSize: 14.0)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const LinearProgressIndicator();
          }
        });
  }
}
