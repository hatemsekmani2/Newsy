import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsy/Models/article_model.dart';

class News{

  List<Article_Model> articals = [];


  Future<void> getNews()async{
    String url = "https://newsapi.org/v2/top-headlines?category=general&apiKey=d1cf939931cc4ebfb616de84a7b0db64";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData["status"] == 'ok'){
      jsonData["articles"].forEach((element) {
            if(element["urlToImage"] != null && element["description"] != null){

              Article_Model article_model = Article_Model(
                author: element["author"],
                title: element["title"],
                content: element["content"],
                description: element["description"],
                url: element["url"],
                urlToImage: element["urlToImage"],
              );
              articals.add(article_model);
            }
          }
        );
    }
  }

}
class CategoryNews{
  String category;
  List<Article_Model> articals = [];

  CategoryNews(this.category);


  Future<void> getNews(String category)async{
    String url = "http://newsapi.org/v2/top-headlines?category=$category&apiKey=d1cf939931cc4ebfb616de84a7b0db64";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData["status"] == 'ok'){
      jsonData["articles"].forEach((element) {
        if(element["urlToImage"] != null && element["description"] != null){

          Article_Model article_model = Article_Model(
            author: element["author"],
            title: element["title"],
            content: element["content"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
          );
          articals.add(article_model);
        }
      }
      );
    }
  }
  String countries = "be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za";
}
class SpecificNews{
  String keyword;
  List<Article_Model> articals = [];

  SpecificNews(this.keyword);


  Future<void> getNews(String keyword)async{
    String url = "https://newsapi.org/v2/everything?q=$keyword&apiKey=d1cf939931cc4ebfb616de84a7b0db64";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData["status"] == 'ok'){
      jsonData["articles"].forEach((element) {
        if(element["urlToImage"] != null && element["description"] != null){

          Article_Model article_model = Article_Model(
            author: element["author"],
            title: element["title"],
            content: element["content"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
          );
          articals.add(article_model);
        }
      }
      );
    }
  }
  String countries = "be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za";
}



