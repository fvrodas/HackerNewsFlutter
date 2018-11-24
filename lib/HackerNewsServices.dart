import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'Story.dart';

class HackerNewsApi {
  final String baseURL = "https://hacker-news.firebaseio.com/v0/";

  final List<List<dynamic>> newCached = [];
  final List<List<dynamic>> topCached = [];
  final List<List<dynamic>> bestCached = [];

  Future<Story> getStory(int id) async {
    final response =
        await http.get(baseURL + "item/" + id.toString() + ".json");

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Story.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<List<dynamic>>> getNewStories() async {
    if (newCached.length == 0) {
      final response = await http.get(baseURL + "newstories.json");

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        List<dynamic> resp = json.decode(response.body);

        newCached.clear();
        newCached.addAll(generatePages(resp, 30));
        return newCached;

      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load posts');
      }
    } else {
      return newCached;
    }
  }

  Future<List<List<dynamic>>> getTopStories() async {
    if (topCached.length == 0) {
      final response = await http.get(baseURL + "topstories.json");

      if (response.statusCode == 200) {
        List<dynamic> resp = json.decode(response.body);

        topCached.clear();
        topCached.addAll(generatePages(resp, 30));
        return topCached;

      } else {
        throw Exception('Failed to load post');
      }
    } else {
      return topCached;
    }
  }

  Future<List<List<dynamic>>> getBestStories() async {
    if (bestCached.length == 0) {
      final response = await http.get(baseURL + "beststories.json");
      
      if (response.statusCode == 200) {
        List<dynamic> resp = json.decode(response.body);

        bestCached.clear();
        bestCached.addAll(generatePages(resp, 30));
        return bestCached;

      } else {
        throw Exception('Failed to load post');
      }
    } else {
      return bestCached;
    }
  }

  List<List<dynamic>> generatePages(List<dynamic> data, int chunkSize) {
    int pages = (data.length / chunkSize).round();
    int pageStep = chunkSize - 1;
    int start = 0;
    int end = pageStep;
    List<List<dynamic>> result = [];
    for(var i = 1; i <= pages; i++ ) {
      result.add(data.sublist(start,end));
      start = end + 1;
      end = start + pageStep;
      if(end >= data.length) {
        end = data.length - 1;
      }
    }
    return result;
  }
}
