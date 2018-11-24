import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'Story.dart';


class FeedItem extends StatefulWidget {
  FeedItem({Key key, this.story}) : super(key: key);
  final Story story;

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {

  void _openUrl() {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedDetailPage(
                widget.story.title, widget.story.url
              ),
            )
       );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openUrl,
      child: Container(
      margin: EdgeInsets.fromLTRB(4, 2, 4, 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black12, width: 0.6)),
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    widget.story.title != null? widget.story.title : "",
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    softWrap: true,
                  ),
                ),
                Container(child: Text(
                  widget.story.by != null &&  widget.story.score != null? "by " + widget.story.by + " | score " + widget.story.score.toString(): "",
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),)
              ],
            )),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(12)
              ),
              margin: EdgeInsets.all(4.0),
              height: 24,
              width: 24,
              child:Center(
                child:  Text(
                  widget.story.score != null? widget.story.score.toString() : "",
                  maxLines: 1,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}

class FeedDetailPage extends StatelessWidget {
  FeedDetailPage(this.title, this.url);

  final String title;
  final String url;

  void _handleTap() {
      Share.share(this.url);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: this.url,
      appBar: new AppBar(
        title: Text(this.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: _handleTap)
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.amberAccent,
        child: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
