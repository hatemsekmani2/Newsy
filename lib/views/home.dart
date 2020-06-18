import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsy/Helper/data.dart';
import 'package:newsy/Helper/news.dart';
import 'package:newsy/Models/article_model.dart';
import 'package:newsy/Models/category.dart';
import 'package:newsy/views/about%20us.dart';
import 'package:newsy/views/article_view.dart';
import 'package:newsy/views/category_view.dart';
import 'package:newsy/views/specific_articles_view.dart';

class Home extends StatefulWidget{
  Color white , black;
  Home(this.white, this.black);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Home_State(white , black);
  }

}

class Home_State  extends State<Home>{
  Color white , black;
  List<Category_Model> categories = new List();
  List<Article_Model> articles = new List();
  bool _loading = true;

  Home_State(this.white, this.black);

  getNews() async{
    News news = News();
    await news.getNews();
    articles = news.articals;
    setState(() {
      _loading = false;
    });
  }

  @override
  initState(){
    categories = getCategories();
    getNews();
  }
  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'إضغط مرة أخرى للخروج',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white

      );

      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }




  @override
  Widget build(BuildContext context) {
    List<String> arabic_categories = ['الأعمال' , "التسلية" , "عامة" , "الصحة" , "العلوم" , "الرياضة" , "التكنولوجيا"];

    // TODO: implement build
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          backgroundColor: white,
          leading: Padding(
              padding : EdgeInsets.only(left: 15),
              child: GestureDetector(
            onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => About_Us()
            ));
          }, child: Image.asset("lib/Icons/about.png")
              )
          ),
          title: Row(
            children: <Widget>[
              Text("Hi! from " ,style: TextStyle(color: black)),
              Text("Newsy" , style: TextStyle(color: Colors.blue),),
            ],

          ),
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child:GestureDetector(onTap : () {
                    setState(() {
                      _loading = true;
                      getNews();
                    });
                  },child:Icon(Icons.refresh , color: black,)),
              ),
          ]


        ),
        body:_loading?  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("جاري تحميل الأخبار"),
            ],
          ),
        ) : articles.length>0?
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                      itemBuilder: (context , i){

                      return CategoryItem(
                        imageUrl: categories[i].image_Url,
                        category_name: categories[i].category_name,
                        arabic_name: arabic_categories[i]
                      );
                      }
                  ),
                )   ,

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
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
            )
          ),
        ) : Center(
          child: Container(
            alignment: Alignment.center,
            child: Text(
                "نعتذر لايوجد نتائج لأن عدد الزيارات قد وصل للحد الأعلى يرجى المحاولة لاحقا.",
              style: TextStyle(
                  color: Colors.black , fontSize: 15 , fontStyle: FontStyle.italic , fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.search , color: Colors.white,),
          onPressed:(){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => SpecificArticles()
            ));
          },),
      ),
    );
  }
}

class CategoryItem  extends StatelessWidget{
  final String imageUrl  , category_name , arabic_name;
  CategoryItem({this.imageUrl , this.category_name, this.arabic_name});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>Category(category_name.toLowerCase())
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(imageUrl: imageUrl , width: 120 , height: 60, fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 120 ,
              height: 60,
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                color: Colors.black26
                ),
              child: Center(
                child: Text(arabic_name , style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),),
              ),

            )
          ],
        ),
      ),
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
            Text("إضغط للمزيد من التفاصيل" , style: TextStyle(
              fontSize: 15,
              color: Colors.black54
            ),)
          ],
        ),
      ),
    );
  }
}
