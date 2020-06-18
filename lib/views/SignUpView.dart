import 'dart:async';

import'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import'package:http/http.dart' as http;
import 'package:newsy/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  Color color = Colors.blue;
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
        keyboardType: TextInputType.text,
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
    return GestureDetector(
      onLongPress: (){
        setState(() {
          color = Colors.blue[700];
        });
      },
      onLongPressEnd: (long){
        setState(() {
          color = Colors.blue;
        });
      },
      onTap: () async{
        setState(() {
          color = Colors.blue[700];
        });
        Timer t = Timer(Duration(milliseconds: 250) , (){
          setState(() {
            color = Colors.blue;
          });
        });
        String username1 =  username.text;
        String phone1 =  phone.text;
        var response , body;
        if(phone1!=""&&username1!=""){
          response = await http.get("http://hatemwebsite.000webhostapp.com/storeAccount.php?username=$username1&phone=$phone1");
          body = response.body;
        }
        else{
          Fluttertoast.showToast(
              msg: 'أحد الحقول أو كلاهما فارغ',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white
          );
        }
        if(body.contains("New record created successfully")) {
          Fluttertoast.showToast(
              msg: 'تم التسجيل بنجاح',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white
          );
          SharedPreferences p = await SharedPreferences.getInstance();
          p.setString("username", username1);

          p.commit();
          Timer t = Timer(Duration(seconds:2) , (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Home(Colors.white , Colors.black)
            ));
          });
        }
        else if(phone1!=""&&username1!=""){
          Fluttertoast.showToast(
              msg: 'أنت مسجل مسبقا',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white
          );
        }



      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 150,
              height: 60,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Center(child: Text("التسجيل" , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w700 ),))),

          ],
        ),
      ),
    );
  }

  logIn() {

  }
  Future<bool>signUp(String username , String phone) async{

  }
}
