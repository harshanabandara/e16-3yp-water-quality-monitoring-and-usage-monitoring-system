import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../src/user_details.dart';
import 'package:http/http.dart';
import '../src/token.dart';

class LoginScreen extends StatefulWidget{
  
  
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen>{
  final postURL = "http://192.168.8.198:3000/login";
  
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formkey = new GlobalKey<FormState>();
  String email = "";
  String password = "";
  String token ;
  LoginResponse res;
  bool islogged = false;


  Widget build(BuildContext context ){ 
    var screenSize = MediaQuery.of(context).size;
    var _height = screenSize.height;
    var _width = screenSize.width;
    print("Height - $_height , width - $_width");
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightGreen[200],
      body: SingleChildScrollView(
      child:Material(
        color: Colors.transparent,
        child: Form(
          key : _formkey,
          child: Column(
          children:[
            Padding(padding: EdgeInsets.only(
              top: 0.0,
              bottom: 15.0,
            )),
            waterCare(),
            Padding(
              padding:EdgeInsets.all(35.0) ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                          
                    emailField(_width, _height),
                    passwordField(),
                    loginButton(),

                ],

              ),
              
              ),
          ],
        )
        ),
      )
      )

    ); 
    

  }

  Widget emailField(double width, double height){
    return TextFormField(
      validator: (value) {
        if(value.contains(".com") && value.contains("@"))
          return null;
        else
          return "Invalid Email Address";
      },
      onSaved: (value){
        email = value;
      },
      decoration: InputDecoration(
        labelText : 'Email',
        labelStyle: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
        hintText: 'yourname@blah.com',
        contentPadding: EdgeInsets.symmetric(vertical: height / 50, horizontal: 5),
      ),
      keyboardType: TextInputType.emailAddress,

    );

  } // emailField

   

  Widget passwordField(){
    return TextFormField(
      validator: (value) {
        if(value.length < 5)
          return "Invalid Password";
        else
          return null;
      },
      onSaved: (value){
        password = value;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
      obscureText: true,
    );
  } // passwordField

  Widget loginButton(){
    return RaisedButton(
      color: Colors.lightGreen,
      elevation: 5.0,

      onPressed: loginButtonFunction,
      child: Text('Login'),

      );
  } //Button

  Widget waterCare(){
    return Container(
              padding: EdgeInsets.all(150.00),
              margin: EdgeInsets.all(50.00),
              alignment: Alignment.center,
              width: 300.00,
              height: 100.00,
              decoration: BoxDecoration(
                image : DecorationImage(
                  scale: 3.0,
                  image: AssetImage("assets/appTitle.png") 
                  //Image.asset('assets/checked.png',scale: 1)
                   )
              ), 
              );

  }

void loginButtonFunction(){
  if(_formkey.currentState.validate())
    approve();
  
  //Navigator.pushNamed(context, '/home');
  

  
}




static const Map<String,String>headers = {
  "Content-type" : "application/json"
};
void approve() async{
  try{
    _formkey.currentState.save();
    String json = '{"email":"$email","password":"$password"}';
    print(json);
    final serverResponse = await post(postURL,body :json,headers:headers);
    print(serverResponse.body);
    int statusCode = serverResponse.statusCode;
    print(statusCode);
    print(serverResponse.headers['set-cookie']);

    var resBody = serverResponse.body;
    var response = jsonDecode(resBody);
    res = LoginResponse.fromJson(response);
    /**
     * if error code == 400 
     * show error message 
     * reset text fields
     */
    if(statusCode == 200){
      savedToken(serverResponse.headers['set-cookie']);
      print(serverResponse.headers['set-cookie']);
      Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => Home(ok:true),
    ));
    }
    else{
      _formkey.currentState.reset();
    }
  }catch(e){
    
    print(e);
  }
}
}

  

