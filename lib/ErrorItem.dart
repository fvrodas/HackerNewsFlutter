import 'package:flutter/material.dart';

class ErrorItem extends StatefulWidget {
  ErrorItem({Key key, this.title, this.text}) : super(key: key);

  final String title;
  final String text;

  @override
  _ErrorItemState createState() => _ErrorItemState();
}

class _ErrorItemState extends State<ErrorItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.redAccent, width: 0.6)),
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    widget.title != null ? widget.title : "",
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    widget.text != null ? widget.text : "",
                    maxLines: 2,
                    style: TextStyle(color: Colors.redAccent, fontSize: 14),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
