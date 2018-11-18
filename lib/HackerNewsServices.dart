import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'Story.dart';

class HackerNewsApi {
  final String baseURL = "https://hacker-news.firebaseio.com/v0/";

  Future<Story> getStory(int id) async {
    final response = await http.get(baseURL + "item/" + id.toString() + ".json");

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Story.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<dynamic>> getNewStories() async {
    final response = await http.get(baseURL + "newstories.json");

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      List<dynamic> resp = json.decode(response.body);

      return resp;

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
