import 'dart:async';

import'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsy/views/SignUpView.dart';
import 'package:http/http.dart' as http;
import 'package:newsy/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
Color color1 = Colors.blue;
Color color2 = Colors.blue;
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Newsy" , style: TextStyle(color: Colors.blue , fontSize: 20),),
          centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset("lib/Icons/Icon.png"),
                  ),
                ),
                UserNameField(username),
                PhoneField(phone),
                Buttons()
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget UserNameField(TextEditingController username) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50)),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: username,
        decoration: InputDecoration(
          hintText: "إسم المستخدم" ,
          helperStyle: TextStyle(color: Colors.blue) ,
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(50),),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(50)),

        ),

      ),
    );
 }
 Widget PhoneField(TextEditingController phone) {
   return Container(
     padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 25),
     decoration: BoxDecoration(
         color: Colors.transparent,
         borderRadius: BorderRadius.circular(50)),
     child: TextFormField(
       textInputAction: TextInputAction.search,
       obscureText: true,
       controller: phone,
       textAlign: TextAlign.center,
       decoration: InputDecoration(
         hintText: "كلمة السر" ,
         helperStyle: TextStyle(color: Colors.blue) ,
         focusedBorder:  OutlineInputBorder(
           borderSide: BorderSide(color: Colors.blue),
           borderRadius: BorderRadius.circular(50),),
         border: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.blue),
             borderRadius: BorderRadius.circular(50)),

       ),

     ),
   );


 }

 Widget Buttons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onLongPress: (){
              setState(() {
                color1 = Colors.blue[700];
              });
            },
            onLongPressEnd: (long){
              setState(() {
                color1 = Colors.blue;
              });
            },
            onTap: () async{
              setState(() {
                color1 = Colors.blue[700];
              });
              Timer t = Timer(Duration(milliseconds: 250) , (){
                setState(() {
                  color1 = Colors.blue;
                });
              });

              var username1 = username.text;
              var phone1 = phone.text;
              var response = await http.get("http://hatemwebsite.000webhostapp.com/getdata.php?username=$username1&phone=$phone1");
              var body = response.body;
              if(body.contains(username.text)&&phone1!=""&&username1!="") {
                Fluttertoast.showToast(
                    msg: 'أهلا بك',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white
                );

                SharedPreferences p = await SharedPreferences.getInstance();
                p.setString("username", username1);

                p.commit();
                Timer t = Timer(Duration(seconds: 2) , (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(Colors.white , Colors.black)
                  ));
                });
              }
              else if(body.contains("[]")){
                Fluttertoast.showToast(
                    msg: "المعلومات خاطئة",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white
                );

              }
              else
              {
                Fluttertoast.showToast(
                    msg: "حدث خطأ ما الرجاء المحاولة لاحقا",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white
                );
              }

            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 150,
              height: 60,
              decoration: BoxDecoration(
                color: color1,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(child: Text("تسجيل الدخول" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w700),))),
          ),

          GestureDetector(
            onLongPress: (){
              setState(() {
                color2 = Colors.blue[700];
              });
            },
            onLongPressEnd: (long){
              setState(() {
                color2 = Colors.blue;
              });
            },
          onTap: (){
   setState(() {
   color2 = Colors.blue[700];
   });
   Timer t = Timer(Duration(milliseconds: 250) , (){
     setState(() {
       color2 = Colors.blue;
     });
   });
   Navigator.push(context, MaterialPageRoute(
   builder: (context) => SignUp()
   ));


   },
            child: Container(
                  alignment: Alignment.centerRight,
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(30)
                  ),
                  child:Center(child: Text("إنشاء حساب" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w700),))),

          ),
        ],
      ),
    );
 }

  Future<bool> logIn(String username , String phone) async{

  }

}
