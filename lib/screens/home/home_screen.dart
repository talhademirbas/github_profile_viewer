import 'package:flutter/material.dart';
import 'package:github_profile_viewer/utils/constants.dart';
import 'package:github_profile_viewer/screens/home/components/repo_card_widget.dart';
import 'package:github_profile_viewer/screens/home/components/user_card_widget.dart';
import 'package:github_profile_viewer/view_model/home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                title: Text(titleText),
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: MyColors.white3)),
            SliverToBoxAdapter(child: indicatorOrEmpty()),
            SliverPadding(
              padding: const EdgeInsets.only(
                  top: MySizes.kDefaultPadding * 2,
                  bottom: MySizes.kDefaultPadding,
                  left: MySizes.kDefaultPadding,
                  right: MySizes.kDefaultPadding),
              sliver: SliverToBoxAdapter(
                child: myFormField(context),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  top: MySizes.kDefaultPadding,
                  left: MySizes.kDefaultPadding,
                  right: MySizes.kDefaultPadding),
              sliver: SliverToBoxAdapter(
                child: UserCardWidget(
                  userModel: userModel,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                  vertical: MySizes.kDefaultPadding * 2,
                  horizontal: MySizes.kDefaultPadding * 2),
              sliver: SliverToBoxAdapter(
                child: getRepoTitle(context),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => RepoCardWidget(
                      reposModel: reposList?[index], colorData: colorData),
                  childCount: reposList?.length ?? 0),
            ),
          ],
        ));
  }
}
