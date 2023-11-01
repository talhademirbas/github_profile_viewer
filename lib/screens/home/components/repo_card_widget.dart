import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          title: NullCheck(
              text: widget._reposmodel?.name,
              textStyle: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: MyColors.blue)),
          subtitle: Padding(
            padding: EdgeInsets.only(top: MySizes.kSmallPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NullCheck(
                    text: widget._reposmodel?.description,
                    textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: MySizes.kDefaultFont,
                        color: MyColors.grey1)),
                Padding(
                  padding: EdgeInsets.only(top: MySizes.kDefaultPadding),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      NullCheck(
                          icon: Icon(Icons.circle,
                              color: _getLanguageColor(
                                  widget._reposmodel?.language),
                              size: MySizes.kSmallIcon),
                          text: widget._reposmodel?.language,
                          icon2: Icon(
                            FontAwesomeIcons.star,
                            size: MySizes.kSmallFont,
                            color: MyColors.grey1,
                          ),
                          text2: widget._reposmodel?.stargazersCount.toString(),
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: MySizes.kDefaultFont,
                                  color: MyColors.grey1),
                          textStyle2: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: MySizes.kDefaultFont,
                                  color: MyColors.grey1)),
                    ],
                  ),
                )
              ],
            ),
          ),
          trailing: const Icon(Icons.chevron_right_outlined),
          onTap: _launchUrl,
        ));
  }

  void _launchUrl() async {
    final Uri url = Uri.parse('${widget._reposmodel?.htmlUrl}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
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
