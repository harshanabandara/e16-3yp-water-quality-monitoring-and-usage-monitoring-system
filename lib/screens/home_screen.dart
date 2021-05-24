import 'dart:async';

import 'package:co227/screens/usage_view.dart';
import 'package:co227/src/token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../src/tank_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'tank_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget{
  bool ok;
  String area;
  String messageTitle = "Empty";
  String notificationAlert = "Alert";
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  HomeState createState() {
    return HomeState(ok:ok,messageTitle:messageTitle,firebaseMessaging:firebaseMessaging,notificationAlert:notificationAlert,area:area);
  }
  Home({bool ok}){
    this.ok = ok;
  }
  
  
}

class HomeState extends State<Home> with WidgetsBindingObserver{
  Timer timer;
  bool waiting = false;


  void initState(){
    super.initState();
    
    getTankList();
    
    print("hello$messageTitle");
    
    firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New notification alert"; 
        });
        print(messageTitle);
      },
      onResume: (message) async{
        setState(() {
          messageTitle=message["data"]["title"];
          notificationAlert = "sick of this shit";

        });
        
      }, 

    );
    WidgetsBinding.instance.addObserver(this);
    setTimer();
  }
  void dispose(){
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  void setTimer(){
    int delayTime = 11;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: delayTime), (t) async{
      if (!waiting) {
        waiting = true;
        await getTankList();
        waiting = false;
        
      }
     });
  }
  

  bool ok;
  String messageTitle;
  String notificationAlert;
  FirebaseMessaging firebaseMessaging ;
  String area;
  final tanksURL = "http://192.168.8.198:3000/tanks";

  HomeState({bool ok, FirebaseMessaging firebaseMessaging, String messageTitle, String notificationAlert, String area}){
    this.ok = ok;
    this.firebaseMessaging = firebaseMessaging;
    this.messageTitle=messageTitle;
    this.notificationAlert=notificationAlert;
    this.area = area;
  }
  List<TankModel> tankList  = [];
  

  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Hello! Thushara",textAlign: TextAlign.center,),),
      backgroundColor: Colors.lightBlue[300],
      drawer: null,
      body: statusImage(ok)
    );
  }

  Widget statusImage(bool status){
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
              image:AssetImage(imageName),
            ),
          ),
        ),
        Text(message,
          style: TextStyle(
            color : Colors.black,
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
  Widget yourTanks(){
    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            color: Colors.blue,
            ),
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(5.00),
          child: FlatButton(
          onPressed: getTanks,
          child: Text("Your Tanks",
          style: TextStyle(
                  color : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 30.0,
                ),
                ),
          ),
        );
  }
  Widget dailyUsage(){
    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            color: Colors.blue,
            ),
          
          
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(5.00),
          child: FlatButton(
          onPressed: getUsage,
          child: Text("Daily Usage",
          style: TextStyle(
                  color : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 30.0,
                ),
                ),
          ),
        );
  }

  void getTanks(){
    //code to navigate
    getTankList();
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Tank(tankList),
    ));
    
    //Tank(tankList);
  }
  void getUsage(){
    getTankList();
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Usage(tankList),
    ));

  }

  Future getTankList() async{
    List<TankModel>temp = [];
    Map <String,String> cookieHeader =  { 
        "Cookie" : await getToken()
   };
        ok = true;
      print(ok);
      Response tankres = await get(tanksURL,headers: cookieHeader);
      
      var tanklist1 = (jsonDecode(tankres.body))['details'] as List;
      // int index = 0;
      int no,tds,level,usage,turbiudity;
      bool issue;
      String email,area;
      Map<String,dynamic> t;
      for (var item in tanklist1) {
        print(item);
        t = item;
        no = int.tryParse(t['no']);
        tds = int.tryParse(t['tds']);
        level = int.tryParse(t['level']);
        usage = int.tryParse(t['usage']);
        turbiudity = int.tryParse(t['turbidity']);
        issue = t['issue'];
        email = t['email'];
        area = t['area'];
        setState(() {
          ok = ok & !issue;
        });
        temp.add( TankModel.Parsed(tds, turbiudity, level, usage, issue, email, area, no));
        
       }
       tankList = temp;
       print(ok);
       print("Length of the tankList: ${tankList.length}\n\n\n\n\n\n\n\n");
       firebaseMessaging.subscribeToTopic(t['area']);
      
  }




}