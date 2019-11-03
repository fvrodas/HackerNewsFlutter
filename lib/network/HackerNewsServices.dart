import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:YAHNC/model/Story.dart';
import 'package:http/http.dart' as http;

class HackerNewsApi {
  final String baseURL = "https://hacker-news.firebaseio.com/v0/";

  HackerNewsApi._privateConstructor();

  static final HackerNewsApi _instance = HackerNewsApi._privateConstructor();

  static HackerNewsApi get instance {
    return _instance;
  }

  Future<Story> getStory(int id) async {
    final response =
        await http.get(baseURL + "item/" + id.toString() + ".json");
    if (response.statusCode == 200) {
      print(response.body);
      return Story.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<void> getNewStories(NetworkCallback<List<int>> _callback) async {
    final response = await http.get(baseURL + "newstories.json");
    print(response.request.url);
    if (response.statusCode == 200) {
      _callback.onSuccess(_callback.asResponse(response.body));
    } else {
      _callback.onError('Failed loading posts');
    }
  }

  Future<void> getTopStories(NetworkCallback<List<int>> _callback) async {
    final response = await http.get(baseURL + "topstories.json");
    print(response.request.url);
    if (response.statusCode == 200) {
      _callback.onSuccess(_callback.asResponse(response.body));
    } else {
      _callback.onError('Failed loading posts');
    }
  }

  Future<void> getBestStories(NetworkCallback<List<int>> _callback) async {
    final response = await http.get(baseURL + "beststories.json");
    print(response.request.url);
    if (response.statusCode == 200) {
      _callback.onSuccess(_callback.asResponse(response.body));
    } else {
      _callback.onError('Failed loading posts');
    }
  }
}

class NetworkCallback<T> {
  NetworkCallback({this.onSuccess, this.onError, this.asResponse});

  void Function(T response) onSuccess;
  void Function(String error) onError;
  T Function(String json) asResponse;
}
