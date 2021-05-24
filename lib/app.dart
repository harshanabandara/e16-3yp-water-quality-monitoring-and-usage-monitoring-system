import 'package:co227/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

class App extends StatelessWidget{
  
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      accentColor: Colors.blueAccent,
    ),
    home: LoginScreen(),        
      routes: {
        '/home' : (context) =>Home(),
        '/login': (context) =>LoginScreen()
      },
      
    );


  

  }
  
} 