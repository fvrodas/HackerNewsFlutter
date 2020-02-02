import 'dart:async';

import 'package:flutter/material.dart';
import 'package:YAHNC/model/Story.dart';
import 'package:YAHNC/ui/webview/WebViewPage.dart';

class FeedItem extends StatelessWidget {
  FeedItem({Key key, this.story, this.index}) : super(key: key);
  final Story story;
  final int index;

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
      color: Theme.of(context).brightness == Brightness.light?
      (index % 2 == 0? Colors.grey[200] : Theme.of(context).backgroundColor) :
      (index % 2 == 0? Colors.grey[900] : Theme.of(context).backgroundColor),
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        child: ListTile(
          title: Text(
            story.title != null ? story.title : "",
            maxLines: 2,
            style: Theme.of(context).textTheme.title,
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
