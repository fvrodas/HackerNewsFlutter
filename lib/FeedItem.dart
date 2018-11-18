import 'package:flutter/material.dart';

class FeedItem extends StatefulWidget {
  FeedItem({Key key, this.title, this.text, this.score}) : super(key: key);

  final String title;
  final String text;
  final String score;

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black26, width: 0.6)),
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
            Text(
              widget.score != null? widget.score : "",
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
