import 'package:flutter/material.dart';
import 'FeedItem.dart';
import 'ErrorItem.dart';
import 'HackerNewsServices.dart';

void main() => runApp(HackerNewsApp());

class HackerNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News Feed',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FeedPage(
          title: 'Hacker News'
      ),
    );
  }
}

class FeedPage extends StatefulWidget {
  FeedPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  bool _isLoading = false;
  List<Widget> _stories = List();
  HackerNewsApi api = HackerNewsApi();

  void _refreshFeed() {
    setState(() {
      _isLoading = true;
    });
    api.getNewStories().then((r) {
      _stories.clear();
      for (final i in r) {
        api.getStory(i as int).then((story) {
          _stories.add(FeedItem(
            title: story.title,
            text: "by " + story.by,
            score: story.score.toString(),
            url: story.url,
          ));
          watch(r.length, _stories.length);
        }).catchError(() {
          setState(() {
            _stories.add(ErrorItem(
              title: "Error",
              text: "Error while obtaining data",
            ));
            _isLoading = false;
          });
        });
      }
    }).catchError(() {
      setState(() {
        _stories.add(ErrorItem(
          title: "Error",
          text: "Error while obtaining data",
        ));
        _isLoading = false;
      });
    });
  }

  void watch(int a, int b) {
    if (a == b) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: _stories,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshFeed,
        tooltip: 'Reload feed',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
