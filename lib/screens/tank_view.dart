//import 'dart:js';

import 'package:co227/src/tank_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Tank extends StatelessWidget{

  final List<TankModel> tanks;

  Tank(this.tanks);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Tanks"),
      ),
      backgroundColor: Colors.lightBlue[300],
      body:
        Center(
          child:GridView.count(
            shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          tankView(0,tanks[0].level, tanks[0].issue,context),
          tankView(1,tanks[1].level, tanks[1].issue,context),
          tankView(2,tanks[2].level, tanks[2].issue,context),
          

        ],
      ),

    ),
    );
  }


  Widget tankView(int index,int waterlevel,bool ok,BuildContext context){
    String image = imageByLevel(waterlevel, ok);
    return  Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        image:DecorationImage(image:AssetImage(image) )
        
      ),
      child: FlatButton(onPressed: (){
        return showDialog(
          context: context,
          builder: (ctx) =>AlertDialog(
            title: Text("Tank ${tanks[index].no}"),
            content: Text("TDS count: ${tanks[index].tds} \n Turbiudity : ${tanks[index].turbiudity}"),
            actions: [
              FlatButton(onPressed:(){ Navigator.of(ctx).pop();}, child: Text("Ok!"))
            ],
          ),
        );
      } ,child:null),
    );


    
  }

  String imageByLevel(int waterlevel,bool ok){
    String image = "";
    if(waterlevel > 80 && ok)
      image = "assets/tank_full_ok-01.png";
    else if(waterlevel > 80 && !ok)
      image = "assets/tank_full_ok-01.png";
    else if(waterlevel< 81 && waterlevel > 65 && ok)
      image = "assets/tank_70_ok-01-01.png";
    else if(waterlevel< 81 && waterlevel > 65 && !ok)
      image = "assets/tank_70_notok-01.png";  
    else if(waterlevel< 66 && waterlevel > 35 && ok)
      image = "assets/tank_half_ok-01.png";
    else if(waterlevel< 66 && waterlevel > 35 && !ok)
      image = "assets/tank_half_notok-01.png";
    else if(waterlevel< 36 && waterlevel > 10 && ok)
      image = "assets/tank_25_ok-01.png";
    else if(waterlevel< 36 && waterlevel > 10 && !ok)
      image = "assets/tank_25_notok-01.png";      
    else if(waterlevel <11)
      image = "assets/tank_empty-01.png";  

    return image;  
  }

  

  
}