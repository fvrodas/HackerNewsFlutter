
import 'package:flutter/material.dart';

import 'package:YAHNC/ui/home/HomePage.dart';

void main() => runApp(HackerNewsApp());

class HackerNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News Feed',
      theme: ThemeData(
        primarySwatch: Colors.orange,
          primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: Colors.orange
          ),
          iconTheme: IconThemeData(
            color: Colors.orange
          )
        )
      ),
      darkTheme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange,
          accentColor: Colors.orangeAccent,
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
              color: ThemeData.dark().canvasColor,
              elevation: 0,
              actionsIconTheme: IconThemeData(
                  color: Colors.orange
              ),
              brightness: Brightness.dark,
              iconTheme: IconThemeData(
                  color: Colors.orange
              )
          )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(title: "Home")
      },
    );
  }
}
