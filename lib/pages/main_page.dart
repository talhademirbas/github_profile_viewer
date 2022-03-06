import 'package:flutter/material.dart';
import 'package:github_profile_viewer/pages/repos_info.dart';
import 'package:github_profile_viewer/pages/user_info.dart';

String? userneym;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Github Profile Viewer'),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          margin: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (text) {
                          userneym = text.toString();
                        },
                        autofocus: false,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          constraints: BoxConstraints(maxHeight: 60.0),
                          hintText: 'Username',
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.deepOrange,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Search'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: const BorderSide(color: Colors.black12),
                          primary: Colors.deepOrange,
                          elevation: 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              usercard(),
              const SizedBox(height: 30),
              const Divider(
                color: Colors.deepOrange,
                thickness: 1.8,
                indent: 40,
                endIndent: 40,
              ),
              Expanded(child: repocards()),
            ],
          ),
        ),
      ),
    );
  }
}

usercard() {
  if (userneym == null) {
    return const Text('Hi, enter the username you want to view',
        style: TextStyle(fontSize: 18));
  } else {
    return UserInfo(userneym!);
  }
}

repocards() {
  if (userneym == null) {
    return const SizedBox();
  } else {
    return ReposInfo(userneym!);
  }
}
