import 'package:flutter/material.dart';
import 'Story.dart';
import 'WebViewPage.dart';


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
              MaterialPageRoute(builder: (context) => WebViewPage(
                  title: widget.story.title,
                  url: widget.story.url
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
