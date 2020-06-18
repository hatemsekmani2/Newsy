import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
class About_Us extends StatelessWidget{

  String appName , version , buildNumber;
  About_Us(){
    PackageInfo.fromPlatform().then((PackageInfo packageInfo){
      appName = packageInfo.appName;
      version = packageInfo.version.toString();
      buildNumber = packageInfo.buildNumber;
    });
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("lib/Icons/Icon.png"),
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("NEWSY :" , style: TextStyle(color: Colors.blue , fontSize: 15 , fontWeight: FontWeight.w500),),
                Text(" VERSION :  1.0.0+1", style: TextStyle(color: Colors.black , fontSize: 15 , fontStyle: FontStyle.italic , fontWeight: FontWeight.w300),)
              ],),
            ),
            SizedBox(height: 20,),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text("Contact Email :" , style: TextStyle(color: Colors.blue , fontSize: 15 , fontWeight: FontWeight.w500),),
              Text(" hatemsekmani@gmail.com", style: TextStyle(color: Colors.black , fontSize: 15 , fontStyle: FontStyle.italic , fontWeight: FontWeight.w300),)
            ],),),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Center(
                    child:Text(
                      "This application is a news application to stay close with all fresh news , also give the choice to select and watch specific news as the person like. ",
                      style: TextStyle(color: Colors.black , fontSize: 15 , fontStyle: FontStyle.italic , fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    )
              ),
            )
          ],
          ),
        ),
      ),
    );
  }

}