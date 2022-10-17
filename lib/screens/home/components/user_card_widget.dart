import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_profile_viewer/components/null_check_widget.dart';
import 'package:github_profile_viewer/utils/constants.dart';
import 'package:github_profile_viewer/service/model/user_model.dart';

class UserCardWidget extends StatefulWidget {
  const UserCardWidget({required UserModel? userModel, Key? key})
      : _userModel = userModel,
        super(key: key);

  final UserModel? _userModel;

  @override
  State<UserCardWidget> createState() => _UserCardWidgetState();
}

class _UserCardWidgetState extends State<UserCardWidget> {
  final String _followersText = "followers";
  final String _followingText = "following";
  final String _greetingText = "Hi, enter a username to view";
  final MySizes _mySizes = MySizes();

  @override
  Widget build(BuildContext context) {
    return widget._userModel == null
        ? _greetingBox(context)
        : _userCard(context);
  }

  Card _userCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(_mySizes.kSmallPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: _mySizes.kDefaultPadding),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: widget._userModel?.avatarUrl != null
                    ? CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        radius: _mySizes.kDefaultPadding * 3,
                        backgroundImage:
                            NetworkImage(widget._userModel!.avatarUrl!))
                    : const SizedBox.shrink(),
                title: NullCheck(
                    text: widget._userModel?.name,
                    textStyle: Theme.of(context).textTheme.headline6),
                subtitle: NullCheck(
                    text: widget._userModel?.login,
                    textStyle: Theme.of(context).textTheme.subtitle1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _mySizes.kDefaultPadding),
              child: NullCheck(
                  text: widget._userModel?.bio,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _mySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: Icon(FontAwesomeIcons.briefcase,
                      size: _mySizes.kSmallIcon,
                      color: Theme.of(context).colorScheme.primary),
                  text: widget._userModel?.company,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _mySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: Icon(FontAwesomeIcons.locationDot,
                      size: _mySizes.kSmallIcon,
                      color: Theme.of(context).colorScheme.primary),
                  text: widget._userModel?.location,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _mySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: Icon(FontAwesomeIcons.link,
                      size: _mySizes.kSmallIcon,
                      color: Theme.of(context).colorScheme.primary),
                  text: widget._userModel?.blog,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _mySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: Icon(FontAwesomeIcons.twitter,
                      size: _mySizes.kSmallIcon,
                      color: Theme.of(context).colorScheme.primary),
                  text: widget._userModel?.twitterUsername,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _mySizes.kDefaultPadding / 2),
              child: NullCheck(
                  text: "${widget._userModel?.followers}",
                  parameter1: _followersText,
                  text2: "${widget._userModel?.following}",
                  parameter2: _followingText,
                  icon: Icon(FontAwesomeIcons.solidUser,
                      size: _mySizes.kSmallIcon,
                      color: Theme.of(context).colorScheme.primary),
                  icon2: Icon(FontAwesomeIcons.circle,
                      size: _mySizes.kSmallIcon / 2,
                      color: Theme.of(context).colorScheme.primary),
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
  }

  FittedBox _greetingBox(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: EdgeInsets.all(_mySizes.kDefaultPadding * 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.github, size: _mySizes.kDefaultPadding * 3),
            Padding(
              padding: EdgeInsets.only(top: _mySizes.kDefaultPadding / 2),
              child: Text(
                _greetingText,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontSize: _mySizes.kDefaultPadding * 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
