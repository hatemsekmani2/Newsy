import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/gestures.dart';
import'package:flutter/material.dart';
import 'package:newsy/Helper/news.dart';
import 'package:newsy/Models/article_model.dart';
import 'package:newsy/views/article_view.dart';
import 'package:newsy/views/home.dart';
class SpecificArticles extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SpecificArticlesState();
  }

}

class SpecificArticlesState extends State<SpecificArticles>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar:  AppBar(
        actions: <Widget>[
          Icon(Icons.add , color: Colors.white,),
          Icon(Icons.add , color: Colors.white,)
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
        padding: EdgeInsets.all(10),
        child: SearchBar<Article_Model>(
          onSearch: getAllSpecificArticles ,
          onItemFound: DrawThePost,
          cancellationWidget: Icon(Icons.cancel),
          hintText: "اكتب كلمة ما للبحث",
          emptyWidget: Center(child: Text("لا يوجد نتائج" , style: TextStyle(color: Colors.grey , fontSize: 15),),),
          minimumChars: 1,
          searchBarStyle: SearchBarStyle(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Future<List<Article_Model>> getAllSpecificArticles(String text) async{
    List<Article_Model> articles = new List();
      SpecificNews news = SpecificNews(text);
      await news.getNews(text);
      articles = news.articals;
      return articles;
  }

  Widget DrawThePost(Article_Model article, int index) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Article(article.url)
        ));
      },
        child: BlogTile(url: article.url, imageUrl: article.urlToImage, desc: article.description , title: article.title,));
  }
}