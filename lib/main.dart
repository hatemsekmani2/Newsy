import 'package:flutter/material.dart';
import 'package:newsy/views/FirstPage.dart';
import 'package:newsy/views/home.dart';

void main() => runApp(FirstPage());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: Colors.black
          ),
          //color: Colors.white
        )

      ),
      home: Home(Colors.white , Colors.black),
    );
  }
}

