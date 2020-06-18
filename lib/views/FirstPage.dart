import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newsy/main.dart';
import 'package:newsy/views/LogInView.dart';
import 'package:newsy/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage  extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  MaterialApp(

      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          //color: Colors.white,
            actionsIconTheme: IconThemeData(
            color: Colors.black,
        )
        )
      ),
      debugShowCheckedModeBanner: false,

      home:  StateFirst(),
    );;
  }
}

class StateFirst extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

   Timer t =  Timer(Duration(seconds: 3), () async{
     SharedPreferences p = await SharedPreferences.getInstance();
     if(p.containsKey("username"))
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(Colors.white , Colors.black)
      ));
     else
       Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder: (context) => SignIn()
    ));
     });
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset("lib/large.png"),
      ),
    );
  }

  void goToHome(BuildContext context) {


  }
}
