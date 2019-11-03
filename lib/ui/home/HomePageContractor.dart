import 'dart:async';
import 'dart:convert';

import 'package:YAHNC/model/Story.dart';
import 'package:YAHNC/network/HackerNewsServices.dart';
import 'package:YAHNC/ui/common/IPresenter.dart';
import 'package:YAHNC/ui/common/IView.dart';
import 'package:YAHNC/ui/common/Tools.dart';

class IHomePageView extends IView {
  onNewStoriesRetrieved(List<List<int>> stories) {}

  onTopStoriesRetrieved(List<List<int>> stories) {}

  onBestStoriesRetrieved(List<List<int>> stories) {}
}

class IHomePagePresenter<T extends IHomePageView>
    extends IPresenter<IHomePageView> {
  getNewStories() {}
  getTopStories() {}
  getBestStories() {}
  Future<Story> getStory(int id) async{ return null; }
}

class HomePagePresenter implements IHomePagePresenter<IHomePageView> {
  IHomePageView _view;

  @override
  void attach(IHomePageView view) {
    _view = view;
  }

  @override
  void dispose() {
    _view = null;
  }

  @override
  getBestStories() {
    _view.setLoading(true);
    var callback = NetworkCallback<List<int>>(
      onSuccess: (stories) {
        var pages = Tools.generatePages(stories, 10);
        _view.setLoading(false);
        _view.onNewStoriesRetrieved(pages);
      },
      onError: (message) {
        _view.setLoading(false);
        _view.showMessage(message);
      },
      asResponse: (jsonData) {
        return (json.decode(jsonData) as List<dynamic>).map((d) => d as int).toList();
      }
    );
    HackerNewsApi.instance.getBestStories(callback);
  }

  @override
  getNewStories() {
    _view.setLoading(true);
    var callback = NetworkCallback<List<int>>(
        onSuccess: (stories) async {
          var pages = Tools.generatePages(stories, 10);
          _view.setLoading(false);
          _view.onNewStoriesRetrieved(pages);
        },
        onError: (message) {
          _view.setLoading(false);
          _view.showMessage(message);
        },
        asResponse: (jsonData) {
          return (json.decode(jsonData) as List<dynamic>).map((d) => d as int).toList();
        }
    );
    HackerNewsApi.instance.getNewStories(callback);
  }

  @override
  getTopStories() {
    _view.setLoading(true);
    var callback = NetworkCallback<List<int>>(
        onSuccess: (stories) {
          var pages = Tools.generatePages(stories, 10);
          _view.setLoading(false);
          _view.onNewStoriesRetrieved(pages);
        },
        onError: (message) {
          _view.setLoading(false);
          _view.showMessage(message);
        },
        asResponse: (jsonData) {
          return (json.decode(jsonData) as List<dynamic>).map((d) => d as int).toList();
        }
    );
    HackerNewsApi.instance.getTopStories(callback);
  }

  @override
  Future<Story> getStory(int id) {
    return HackerNewsApi.instance.getStory(id);
  }

}