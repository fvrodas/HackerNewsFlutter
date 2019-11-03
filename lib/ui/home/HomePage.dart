import 'dart:async';

import 'package:YAHNC/model/Story.dart';
import 'package:YAHNC/ui/common/FeedItem.dart';
import 'package:flutter/material.dart';

import 'HomePageContractor.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements IHomePageView {
  bool _isLoading = false;
  int _pages = 0;
  int _currentTab = 0;
  int _currentPage = 0;
  List<Widget> _page = List();
  List<List<int>> _stories = List();
  HomePagePresenter _presenter = HomePagePresenter();

  Future<void> _refreshNewsFeed() {
    switch (_currentTab) {
      case 0:
        _presenter.getNewStories();
        break;
      case 1:
        _presenter.getTopStories();
        break;
      case 2:
        _presenter.getBestStories();
        break;
    }
    setState(() {
      _currentPage = 0;
    });
  }

  void _loadPage(List<Story> page) {
    _page.clear();

    for (final i in page) {
      setState(() {
        _page.add(FeedItem(
          key: UniqueKey(),
          story: i,
        ));
      });
    }
    setLoading(false);
  }

  void _nextPage() async {
    if (_currentPage <= _pages) {
      setState(() {
        _currentPage++;
      });
      setLoading(true);
      var stories = List<Story>();
      for (var e in _stories[_currentPage]) {
        stories.add(await _presenter.getStory(e));
      }
      _loadPage(stories);
    }
  }

  void _previousPage() async {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      setLoading(true);
      var stories = List<Story>();
      for (var e in _stories[_currentPage]) {
        stories.add(await _presenter.getStory(e));
      }
      _loadPage(stories);
    }
  }

  void _loadTab(int i) {
    setState(() {
      _currentPage = 0;
      _currentTab = i;
    });
    _refreshNewsFeed();
  }

  @override
  void initState() {
    _presenter.attach(this);
    super.initState();
    _presenter.getNewStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: ThemeData.dark().textTheme.title.color),),
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
                        onRefresh: () => _refreshNewsFeed()),
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

  @override
  onBestStoriesRetrieved(List<List<int>> stories) {
    _stories.clear();
    _stories.addAll(stories);
    setState(() {
      _pages = _stories.length ?? 0;
    });
    if (_pages > 0) _loadFirstPage();
  }

  @override
  onNewStoriesRetrieved(List<List<int>> stories) {
    _stories.clear();
    _stories.addAll(stories);
    setState(() {
      _pages = _stories.length ?? 0;
    });
    if (_pages > 0) _loadFirstPage();
  }

  @override
  onTopStoriesRetrieved(List<List<int>> stories) {
    _stories.clear();
    _stories.addAll(stories);
    setState(() {
      _pages = _stories.length ?? 0;
    });
    if (_pages > 0) _loadFirstPage();
  }

  @override
  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _loadFirstPage() async {
    setLoading(true);
    var stories = List<Story>();
    for (var e in _stories[_currentPage]) {
      stories.add(await _presenter.getStory(e));
    }
    return _loadPage(stories);
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
  }
}
