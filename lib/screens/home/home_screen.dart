import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_profile_viewer/components/snack_bar_widget.dart';
import 'package:github_profile_viewer/utils/constants.dart';
import 'package:github_profile_viewer/screens/home/components/repo_card_widget.dart';
import 'package:github_profile_viewer/screens/home/components/user_card_widget.dart';
import 'package:github_profile_viewer/service/get_service.dart';
import 'package:github_profile_viewer/service/model/repos_model.dart';
import 'package:github_profile_viewer/service/model/user_model.dart';
import 'package:github_profile_viewer/service/service_base.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _titleText = "Github Profile Viewer";
  final String _hintText = "Username";
  final String _emptyInputText = "Username can't be empty";
  final String _repoTitle = "Repositories";
  final String _noRepoMessage = "This user doesn't have a repository :/";
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _myFocusNode = FocusNode();
  final ServiceBase _getService = GetService();
  final _formKey = GlobalKey<FormState>();
  final MySizes _mySizes = MySizes();
  List<ReposModel>? _reposList;
  UserModel? _userModel;
  bool _isLoading = false;

  @override
  void dispose() {
    _myFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(title: Text(_titleText)),
            SliverToBoxAdapter(child: _indicatorOrEmpty()),
            SliverPadding(
              padding: EdgeInsets.only(
                  top: _mySizes.kDefaultPadding * 2,
                  left: _mySizes.kDefaultPadding,
                  right: _mySizes.kDefaultPadding),
              sliver: SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: _myTextFormField(context),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(_mySizes.kDefaultPadding),
              sliver: SliverToBoxAdapter(
                child: UserCardWidget(
                  userModel: _userModel,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  vertical: _mySizes.kDefaultPadding,
                  horizontal: _mySizes.kDefaultPadding * 2),
              sliver: SliverToBoxAdapter(
                child: _getRepoTitle(context),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      RepoCardWidget(reposModel: _reposList?[index]),
                  childCount: _reposList?.length ?? 0),
            ),
          ],
        ));
  }

  Widget _getRepoTitle(BuildContext context) {
    if (_reposList == null) {
      return const SizedBox.shrink();
    } else if (_reposList!.isEmpty) {
      return Text(_noRepoMessage, style: Theme.of(context).textTheme.headline6);
    } else {
      return Text(
        _repoTitle,
        style: Theme.of(context).textTheme.headline6,
      );
    }
  }

  TextFormField _myTextFormField(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return _emptyInputText;
          }
          return null;
        },
        onEditingComplete: _isLoading ? null : _formOnPressed,
        autofocus: true,
        focusNode: _myFocusNode,
        controller: _textEditingController,
        textInputAction: TextInputAction.done,
        maxLength: 39,
        decoration: InputDecoration(
            errorStyle: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: Theme.of(context).errorColor),
            counterStyle: Theme.of(context).textTheme.bodyText2,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_mySizes.kDefaultPadding)),
            prefixIcon: const Icon(Icons.account_circle),
            labelText: _hintText,
            suffixIcon: IconButton(
              onPressed: _isLoading ? null : _formOnPressed,
              icon: Icon(FontAwesomeIcons.magnifyingGlass,
                  size: _mySizes.kDefaultPadding * 2),
            )));
  }

  Function? _formOnPressed() {
    if (_formKey.currentState!.validate()) {
      _searchOnPressed();
    }
    return null;
  }

  Future<void> _fetchItems({required String username}) async {
    _changeLoading(true);
    try {
      _userModel = await _getService.fetchUserItems(username);
      _reposList = await _getService.fetchRepoItems(username);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: SnackBarWidget(message: "$e")));
      //debugPrint(e.toString());
    }
    _changeLoading(false);
  }

  void _changeLoading(bool _input) {
    setState(() {
      _isLoading = _input;
    });
  }

  void _searchOnPressed() {
    _myFocusNode.unfocus();
    _fetchItems(username: _textEditingController.text);
  }

  SingleChildRenderObjectWidget _indicatorOrEmpty() {
    return _isLoading
        ? Center(
            child: LinearProgressIndicator(
            minHeight: _mySizes.kDefaultPadding / 2,
          ))
        : SizedBox(height: _mySizes.kDefaultPadding / 2);
  }
}
