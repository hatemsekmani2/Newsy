import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsy/Helper/data.dart';
import 'package:newsy/Helper/news.dart';
import 'package:newsy/Models/article_model.dart';
import 'package:newsy/views/article_view.dart';
import 'package:newsy/views/home.dart';
class Category extends StatefulWidget{

  String category;
  Category(this.category);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Category_State(category);
  }

}

class Category_State  extends State<Category>{
   String category;
   Category_State(this.category);
  List<Article_Model> articles = new List();
  bool _loading = true;
  getCategoryNews() async{
    CategoryNews news = CategoryNews(category);
    await news.getNews(category);
    articles = news.articals;
    setState(() {
      _loading = false;
    });
  }

  @override
  initState(){
    getCategoryNews();
  }

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
      body: _loading?  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("جاري تحميل الأخبار"),
          ],
        ),
      ) :
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: articles.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context , i){

                    return BlogTile(
                      imageUrl: articles[i].urlToImage,
                      title: articles[i].title,
                      desc: articles[i].description,
                      url: articles[i].url,
                    );
                  },

                ),
              )
            ],
          ),
        ),
      )

    );
  }
}
class BlogTile extends StatelessWidget {
  final String imageUrl , title , desc , url;
  BlogTile({this.imageUrl , this.title , this.desc , this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Article(url)));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: [
                  ClipRRect(child: CachedNetworkImage(imageUrl: imageUrl , fit: BoxFit.cover,) , borderRadius: BorderRadius.circular(20),),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent
                    ),
                  )
                ],
              )
              ,),
            SizedBox(height: 5,),
            Text(
              title ,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500
              ),),
            Text(
                  "إضغط للمزيد من التفاصيل" , style: TextStyle(
                  fontSize: 15,
                   color: Colors.black54
              ),
            ),
          ],
        ),
      ),
    );
  }
}
