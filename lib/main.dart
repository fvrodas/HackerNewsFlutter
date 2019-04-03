import 'dart:async';

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
      home: FeedPage(title: 'YAHNC'),
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
  int _pages = 0;
  int _currentTab = 0;
  int _currentPage = 0;
  List<Widget> _page = List();
  List<List<dynamic>> _stories = List();
  HackerNewsApi api = HackerNewsApi();

  void _refreshNewsFeed() {
    setState(() {
      _isLoading = true;
    });
    switch (_currentTab) {
      case 0:
        {
          api.getNewStories().then((r) {
            _pages = r.length;
            _stories = r;
            _loadPage(r[0]);
          }, onError: (error) {
            setState(() {
              _page.add(ErrorItem(
                title: "Error",
                text: "Error while obtaining data",
              ));
              _isLoading = false;
            });
          });
          break;
        }
      case 1:
        {
          api.getTopStories().then((r) {
            _pages = r.length;
            _stories = r;
            _loadPage(r[0]);
          }, onError: (error) {
            setState(() {
              _page.add(ErrorItem(
                title: "Error",
                text: "Error while obtaining data",
              ));
              _isLoading = false;
            });
          });
          break;
        }
      case 2:
        {
          api.getBestStories().then((r) {
            _pages = r.length;
            _stories = r;
            _loadPage(r[0]);
          }, onError: (error) {
            setState(() {
              _page.add(ErrorItem(
                title: "Error",
                text: "Error while obtaining data",
              ));
              _isLoading = false;
            });
          });
          break;
        }
    }
  }

  void _loadPage(List<dynamic> page) {
    _page.clear();
    for (final i in page) {
      api.getStory(i as int).then((story) {
        _page.add(FeedItem(
          story: story,
        ));
        watch(page.length, _page.length);
      }, onError: (error) {
        setState(() {
          _page.add(ErrorItem(
            title: "Error",
            text: "Error while obtaining data",
          ));
          _isLoading = false;
        });
      });
    }
  }

  void _nextPage() {
    if (_currentPage <= _pages) {
      setState(() {
        _currentPage++;
        _isLoading = true;
      });

      _loadPage(_stories[_currentPage]);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _isLoading = true;
      });

      _loadPage(_stories[_currentPage]);
    }
  }

  Future<void> _reloadStories() async {
    switch(_currentTab) {
      case 0: {
        api.newCached.clear();
        break;
      }
      case 1: {
        api.topCached.clear();
        break;
      }
      case 2: {
        api.bestCached.clear();
        break;
      }
    }
    return _refreshNewsFeed();
  }

  void _loadTab(int i) {
    setState(() {
      _currentPage = 0;
      _currentTab = i;
    });
    _refreshNewsFeed();
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
    _refreshNewsFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: _isLoading
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.navigate_before),
                          onPressed: _previousPage,
                        ),
                        Expanded(
                          child: Center(
                            child: Text((_currentPage + 1).toString() +
                                " of " +
                                _pages.toString()),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: _nextPage,
                        )
                      ],
                    ),
                  )
                ],
              )
            : Column(
                children: <Widget>[
                  Expanded(
                    child: RefreshIndicator(
                        child: ListView(
                          children: _page,
                        ),
                        onRefresh: _reloadStories),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.navigate_before),
                          onPressed: _previousPage,
                        ),
                        Expanded(
                          child: Center(
                            child: Text((_currentPage + 1).toString() +
                                " of " +
                                _pages.toString()),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: _nextPage,
                        )
                      ],
                    ),
                  )
                ],
              ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _loadTab,
          currentIndex: _currentTab,
          items: [
            BottomNavigationBarItem(
                title: Text("New Stories"),
                icon: Icon(Icons.schedule, color: Colors.grey),
                activeIcon: Icon(Icons.schedule, color: Colors.orangeAccent)),
            BottomNavigationBarItem(
                title: Text("Top Stories"),
                icon: Icon(Icons.sort, color: Colors.grey),
                activeIcon: Icon(Icons.sort, color: Colors.orangeAccent)),
            BottomNavigationBarItem(
                title: Text("Best Stories"),
                icon: Icon(Icons.favorite, color: Colors.grey),
                activeIcon: Icon(Icons.favorite, color: Colors.orangeAccent))
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
