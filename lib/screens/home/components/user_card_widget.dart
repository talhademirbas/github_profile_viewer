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
        padding: const EdgeInsets.all(MySizes.kSmallPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: MySizes.kDefaultPadding),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: widget._userModel?.avatarUrl != null
                    ? CircleAvatar(
                        radius: MySizes.kBoldCircle,
                        backgroundColor: MyColors.white3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                              radius: MySizes.kCircle,
                              backgroundColor: MyColors.white3,
                              child: Image.network(
                                widget._userModel!.avatarUrl!,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: Transform.scale(
                                      scale: 0.8,
                                      child: CircularProgressIndicator(
                                        value: (loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null),
                                      ),
                                    ),
                                  );
                                },
                              )),
                        ),
                      )
                    : const SizedBox.shrink(),
                title: NullCheck(
                    text: widget._userModel?.name,
                    textStyle: Theme.of(context).textTheme.titleLarge),
                subtitle: NullCheck(
                    text: widget._userModel?.login,
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                            color: MyColors.grey1,
                            fontWeight: FontWeight.w300)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: MySizes.kDefaultPadding),
              child: NullCheck(
                  text: widget._userModel?.bio,
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: MyColors.grey2,
                      fontSize: 14)),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: const Icon(FontAwesomeIcons.briefcase,
                      size: MySizes.kSmallIcon, color: MyColors.grey1),
                  text: widget._userModel?.company,
                  textStyle: Theme.of(context).textTheme.bodyMedium),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: const Icon(FontAwesomeIcons.locationDot,
                      size: MySizes.kSmallIcon, color: MyColors.grey1),
                  text: widget._userModel?.location,
                  textStyle: Theme.of(context).textTheme.bodyMedium),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: const Icon(FontAwesomeIcons.link,
                      size: MySizes.kSmallIcon, color: MyColors.grey1),
                  text: widget._userModel?.blog,
                  textStyle: Theme.of(context).textTheme.bodyMedium),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                  icon: const Icon(FontAwesomeIcons.twitter,
                      size: MySizes.kSmallIcon, color: MyColors.grey1),
                  text: widget._userModel?.twitterUsername,
                  textStyle: Theme.of(context).textTheme.bodyMedium),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: MySizes.kDefaultPadding / 2),
              child: NullCheck(
                text: "${widget._userModel?.followers}",
                parameter1: _followersText,
                text2: "${widget._userModel?.following}",
                parameter2: _followingText,
                icon: const Icon(FontAwesomeIcons.solidUser,
                    size: MySizes.kSmallIcon, color: MyColors.grey1),
                icon2: const Icon(Icons.circle,
                    size: MySizes.kSmallIcon / 5, color: MyColors.grey1),
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
        padding: const EdgeInsets.all(MySizes.kDefaultPadding * 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.github,
                size: MySizes.kDefaultPadding * 3),
            Padding(
              padding: const EdgeInsets.only(top: MySizes.kDefaultPadding / 2),
              child: Text(
                _greetingText,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: MySizes.kDefaultPadding * 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
