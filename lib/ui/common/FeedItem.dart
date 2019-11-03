import 'dart:async';

import 'package:flutter/material.dart';
import 'package:YAHNC/model/Story.dart';
import 'package:YAHNC/ui/webview/WebViewPage.dart';

class FeedItem extends StatelessWidget {
  FeedItem({Key key, this.story}) : super(key: key);
  final Story story;

  void _openUrl(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WebViewPage(title: story.title, url: story.url),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        child: ListTile(
          title: Text(
            story.title != null ? story.title : "",
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            softWrap: true,
          ),
          subtitle: Text(
            "by ${story.by} | score ${story.score.toString() ?? ""}",
            maxLines: 2,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          onTap: () => _openUrl(context),
        ),
      ),
    );
  }
}
