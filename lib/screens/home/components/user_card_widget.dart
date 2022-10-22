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
        padding: EdgeInsets.all(MySizes.kSmallPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: MySizes.kDefaultPadding),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: widget._userModel?.avatarUrl != null
                    ? CircleAvatar(
                        radius: MySizes.kBoldCircle,
                        backgroundColor: MyColors.white3,
                        child: CircleAvatar(
                            radius: MySizes.kCircle,
                            backgroundColor: MyColors.white3,
                            backgroundImage:
                                NetworkImage(widget._userModel!.avatarUrl!)),
                      )
                    : const SizedBox.shrink(),
                title: NullCheck(
                    text: widget._userModel?.name,
                    textStyle: Theme.of(context).textTheme.headline6),
                subtitle: NullCheck(
                    text: widget._userModel?.login,
                    textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: MyColors.grey1, fontWeight: FontWeight.w300)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MySizes.kDefaultPadding),
              child: NullCheck(
                  text: widget._userModel?.bio,
                  textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: MyColors.grey2,
                      fontSize: 14)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: Icon(FontAwesomeIcons.briefcase,
                      size: MySizes.kSmallIcon, color: MyColors.grey1),
                  text: widget._userModel?.company,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: Icon(FontAwesomeIcons.locationDot,
                      size: MySizes.kSmallIcon, color: MyColors.grey1),
                  text: widget._userModel?.location,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: Icon(FontAwesomeIcons.link,
                      size: MySizes.kSmallIcon, color: MyColors.grey1),
                  text: widget._userModel?.blog,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: Icon(FontAwesomeIcons.twitter,
                      size: MySizes.kSmallIcon, color: MyColors.grey1),
                  text: widget._userModel?.twitterUsername,
                  textStyle: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                text: "${widget._userModel?.followers}",
                parameter1: _followersText,
                text2: "${widget._userModel?.following}",
                parameter2: _followingText,
                icon: Icon(FontAwesomeIcons.solidUser,
                    size: MySizes.kSmallIcon, color: MyColors.grey1),
                icon2: Icon(Icons.circle,
                    size: MySizes.kSmallIcon / 5, color: MyColors.grey1),
                textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: MyColors.grey2, fontWeight: FontWeight.w400),
              ),
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
        padding: EdgeInsets.all(MySizes.kDefaultPadding * 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.github, size: MySizes.kDefaultPadding * 3),
            Padding(
              padding: EdgeInsets.only(top: MySizes.kDefaultPadding / 2),
              child: Text(
                _greetingText,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontSize: MySizes.kDefaultPadding * 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
