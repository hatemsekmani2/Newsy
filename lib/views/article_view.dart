import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatefulWidget{
  String url;
  Article(this.url){}
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Article_State(url);
  }

}

class Article_State  extends State<Article>{
  String url;
  final Completer<WebViewController> _completer = Completer();
  Article_State(this.url);
  int loading = 1;

  @override
  void initState() {
    setState(() {
     loading = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {





    // TODO: implement build
     print("loading is : "+loading.toString());
    setProgres() {
      print("loading befor : " + loading.toString());
      return Center(child : Text("Loading"));
    }
    setContainer() {
      print("loading after : "+loading.toString());
      return Container();
    }
    return Scaffold(
      appBar:  AppBar(
        actions: <Widget>[
          Icon(Icons.add , color: Colors.white,),
          Icon(Icons.add , color: Colors.white,),
        ],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Newsy" , style: TextStyle(color: Colors.blue , fontSize: 20),),
          ],

        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: IndexedStack(
          index: loading,
            children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,

            onPageStarted: (string){
                   setState(() {
                     loading = 0;
                     print(loading.toString());
                   });
             },

        initialUrl: url,
        onWebViewCreated: ((WebViewController controller){
          _completer.complete(controller);
        }
        ),
      ),
              Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("جاري التحميل"),
                ],
              ),)
            ])
      ),

    );
  }


}

