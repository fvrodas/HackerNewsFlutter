import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';


class FeedItem extends StatefulWidget {
  FeedItem({Key key, this.title, this.text, this.score, this.url}) : super(key: key);

  final String title;
  final String text;
  final String score;
  final String url;

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {

  void _openUrl() {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedDetailPage(
                widget.title, widget.url
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
                    widget.title != null? widget.title : "",
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(margin: EdgeInsets.only(left: 8),child: Text(
                  widget.text != null? widget.text : "",
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),)
              ],
            )),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12)
              ),
              margin: EdgeInsets.all(4.0),
              height: 24,
              width: 24,
              child:Center(
                child:  Text(
                  widget.score != null? widget.score : "",
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
          GestureDetector(
            onTap: _handleTap,
            child: Center(
              child:Icon(
                Icons.share,
                color: Colors.black,
              )
            ),
          )
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
