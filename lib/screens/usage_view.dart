import 'package:flutter/material.dart';
import '../src/tank_model.dart';

class Usage extends StatelessWidget{
  final List<TankModel> tanks;
  Usage(this.tanks);
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: Colors.lightBlue[300],
      appBar: AppBar(title:Text("Your Usage",textAlign: TextAlign.center)),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          usageCard(0,context),
          usageCard(1,context),
          usageCard(2,context),
          totalUsage(context)
        ],
      ),
      )

    );  
  }
  Widget usageCard(int index,BuildContext context){
    return Container(
      width:MediaQuery.of(context).size.width,
      height: 80.0,
      padding: EdgeInsets.all(10.0),
      child: Card(
        elevation: 5.0,
        color: Colors.grey[50],
        margin: EdgeInsets.only(top :10.0,bottom:10.0),
        child:Text(
          "Tank $index : ${tanks[index].usage} Litres",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
          ),
        
        
        )
      ),
    );
  }
  Widget totalUsage(BuildContext context){
    int sum = tanks[0].usage+tanks[1].usage+tanks[2].usage;
    return Container(
      width:MediaQuery.of(context).size.width,
      child:Card(
        elevation: 20.0,
        child: Text("Total usage : $sum Litres",
            textAlign: TextAlign.center,
             style: TextStyle(
            fontSize: 30.0,
          ),),
      )
    );
  }
}