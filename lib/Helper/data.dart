import 'package:flutter/material.dart';
import 'package:newsy/Models/category.dart';

List<Category_Model> getCategories(){
  List<Category_Model> categories = List();


  Category_Model categorieModel = Category_Model();
  categorieModel.category_name = "Business";
  categorieModel.image_Url = "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80";
  categories.add(categorieModel);


  categorieModel = new Category_Model();
  categorieModel.category_name = "Entertainment";
  categorieModel.image_Url = "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  categories.add(categorieModel);

  //3
  categorieModel = new Category_Model();
  categorieModel.category_name = "General";
  categorieModel.image_Url = "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60";
  categories.add(categorieModel);

  //4
  categorieModel = new Category_Model();
  categorieModel.category_name = "Health";
  categorieModel.image_Url = "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
  categories.add(categorieModel);

  //5
  categorieModel = new Category_Model();
  categorieModel.category_name = "Science";
  categorieModel.image_Url = "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
  categories.add(categorieModel);

  //5
  categorieModel = new Category_Model();
  categorieModel.category_name = "Sports";
  categorieModel.image_Url = "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  categories.add(categorieModel);

  //5
  categorieModel = new Category_Model();
  categorieModel.category_name = "Technology";
  categorieModel.image_Url = "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  categories.add(categorieModel);

  return categories;


}