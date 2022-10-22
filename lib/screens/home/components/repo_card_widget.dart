import 'package:flutter/material.dart';
import 'package:github_profile_viewer/components/null_check_widget.dart';
import 'package:github_profile_viewer/utils/constants.dart';
import 'package:github_profile_viewer/service/model/repos_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoCardWidget extends StatefulWidget {
  const RepoCardWidget({
    Key? key,
    required ReposModel? reposModel,
    required this.colorData,
  })  : _reposmodel = reposModel,
        super(key: key);

  final ReposModel? _reposmodel;
  final Map<String, dynamic> colorData;

  @override
  State<RepoCardWidget> createState() => _RepoCardWidgetState();
}

class _RepoCardWidgetState extends State<RepoCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(
            bottom: MySizes.kDefaultPadding,
            left: MySizes.kDefaultPadding,
            right: MySizes.kDefaultPadding),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: MySizes.kSmallPadding * 2,
              vertical: MySizes.kSmallPadding),
          title: NullCheck(text: widget._reposmodel?.name),
          subtitle: Column(
            children: [
              NullCheck(text: widget._reposmodel?.description),
              Padding(
                padding: EdgeInsets.only(top: MySizes.kDefaultPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    NullCheck(
                        icon: Icon(
                          Icons.star,
                          color: MyColors.yellowAccent,
                          size: MySizes.kDefaultIcon,
                        ),
                        text: widget._reposmodel?.stargazersCount.toString(),
                        icon2: Icon(Icons.circle,
                            color:
                                _getLanguageColor(widget._reposmodel?.language),
                            size: MySizes.kDefaultPadding),
                        text2: widget._reposmodel?.language),
                  ],
                ),
              )
            ],
          ),
          trailing: const Icon(Icons.chevron_right_outlined),
          onTap: _launchUrl,
        ));
  }

  void _launchUrl() async {
    final String? url = widget._reposmodel?.htmlUrl;
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    } else {
      return Colors.transparent;
    }
  }

  Color _getLanguageColor(String? language) {
    String? hexColor = widget.colorData[language];

    if (hexColor != null) {
      return _getColorFromHex(hexColor);
    } else {
      return Colors.transparent;
    }
  }
}
