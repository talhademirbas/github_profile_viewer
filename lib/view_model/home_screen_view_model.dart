import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_profile_viewer/components/snack_bar_widget.dart';
import 'package:github_profile_viewer/screens/home/home_screen.dart';
import 'package:github_profile_viewer/utils/constants.dart';
import 'package:github_profile_viewer/service/get_service.dart';
import 'package:github_profile_viewer/service/model/repos_model.dart';
import 'package:github_profile_viewer/service/model/user_model.dart';
import 'package:github_profile_viewer/service/service_base.dart';
import 'package:github_profile_viewer/utils/validator.dart';

abstract class HomeScreenViewModel extends State<HomeScreen> {
  final String titleText = "GitHub Profile Viewer";
  final String hintText = "Username";
  final String repoTitle = "Repositories";
  final String noRepoMessage = "This user doesn't have a public repository";
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode myFocusNode = FocusNode();
  final ServiceBase getService = GetService();
  final GlobalKey<FormState> formKey = GlobalKey();

  List<ReposModel>? reposList;
  UserModel? userModel;
  bool isLoading = false;
  late final Map<String, dynamic> colorData;

  @override
  void initState() {
    super.initState();
    fetchLanguageJson();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  Widget getRepoTitle(BuildContext context) {
    if (reposList == null) {
      return const SizedBox.shrink();
    } else if (reposList!.isEmpty) {
      return Text(noRepoMessage, style: Theme.of(context).textTheme.titleLarge);
    } else {
      return Text(
        repoTitle,
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
  }

  Widget myFormField(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
          validator: FormValidator().isNotEmpty,
          onEditingComplete: isLoading ? null : formOnPressed,
          autofocus: true,
          focusNode: myFocusNode,
          controller: textEditingController,
          textInputAction: TextInputAction.done,
          maxLength: 39,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: MySizes.kDefaultPadding,
                  vertical: MySizes.kDefaultPadding * 2),
              hintText: hintText,
              prefixIcon:
                  const Icon(Icons.account_circle, color: MyColors.grey1),
              suffixIcon: IconButton(
                splashRadius: 0.1,
                color: MyColors.grey1,
                onPressed: isLoading ? null : formOnPressed,
                icon: const Icon(FontAwesomeIcons.magnifyingGlass,
                    size: MySizes.kDefaultIcon),
              ))),
    );
  }

  Function? formOnPressed() {
    if (formKey.currentState!.validate()) {
      searchOnPressed();
    }
    return null;
  }

  Future<void> fetchItems({required String username}) async {
    changeLoading(true);
    try {
      userModel = await getService.fetchUserItems(username);
      reposList = await getService.fetchRepoItems(username);
      changeLoading(false);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: SnackBarWidget(message: "$e")));
      changeLoading(false);
    }
  }

  void changeLoading(bool input) {
    setState(() {
      isLoading = input;
    });
  }

  void searchOnPressed() {
    myFocusNode.unfocus();
    fetchItems(username: textEditingController.text);
  }

  SingleChildRenderObjectWidget indicatorOrEmpty() {
    return isLoading
        ? const Center(
            child: LinearProgressIndicator(
            minHeight: MySizes.kDefaultPadding / 2,
          ))
        : const SizedBox(height: MySizes.kDefaultPadding / 2);
  }

  Future<void> fetchLanguageJson() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString("assets/local_json/language_colors.json");

    colorData = await json.decode(response);
  }
}
