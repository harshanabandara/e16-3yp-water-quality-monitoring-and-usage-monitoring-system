import 'package:co227/screens/usage_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../src/tank_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'tank_view.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  bool ok;
  HomeState createState() {
    return HomeState(ok: ok);
  }

  Home({bool ok}) {
    this.ok = ok;
  }
}

class HomeState extends State<Home> {
  bool ok;
  HomeState({bool ok}) {
    this.ok = ok;
  }
  List<TankModel> tankList = [];
  final postURL = "http://192.168.8.198:3000/";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hello! Thushara",
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.lightBlue[300],
        drawer: null,
        body: statusImage(ok));
  }

  Widget statusImage(bool status) {
    String imageName = "";
    String message = "";
    if (status) {
      imageName = "assets/checked.png";
      message = "Everything is Ok!";
    } else {
      imageName = "assets/cancel.png";
      message = "Contamination Detected!";
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 230.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageName),
            ),
          ),
        ),
        Text(
          message,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 30.0,
          ),
        ),
        Padding(padding: EdgeInsets.all(10.0)),
        yourTanks(),
        dailyUsage()
      ],
    );
  }

  Widget yourTanks() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
        color: Colors.blue,
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(5.00),
      child: FlatButton(
        onPressed: getTanks,
        child: Text(
          "Your Tanks",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  Widget dailyUsage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
        color: Colors.blue,
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(5.00),
      child: FlatButton(
        onPressed: getUsage,
        child: Text(
          "Daily Usage",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  void getTanks () {
    //async{
    
  
    //get request
/*
    Response res = await get("{$postURL}tanks/");
    var jsonBody = res.body;
    var parsedJsonBody = json.decode(jsonBody);
    var list1 = parsedJsonBody['details'];
    TankModel temp;
    for (int i = 0; i < list1.length; i++) {
      temp = TankModel.fromJson(list1[i]);
      tankList.add(temp);
    }*/
    //code to navigate
    createTankList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Tank(tankList),
        ));

    //Tank(tankList);
  }

  void getUsage() {
    createTankList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Usage(tankList),
        ));
  }

  void createTankList async() {
    Response res = await get("{$postURL}tanks/",headers:headers);
    var jsonBody = res.body;
    var parsedJsonBody = json.decode(jsonBody);
    var list1 = parsedJsonBody['details'];
    TankModel temp;
    for (int i = 0; i < list1.length; i++) {
      temp = TankModel.fromJson(list1[i]);
      tankList.add(temp);
    }
  }
}
