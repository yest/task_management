import 'package:flutter/material.dart';

void main() => runApp(About());

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView widget',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Column(
              children: <Widget>[
                //logo
                new Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage("img/logo_trans.png"),
                    ),
                  ),
                ),
                new Text(
                  "Simple Task",
                  style: new TextStyle(
                    color: Colors.teal,
                    fontSize: 30.0,
                    letterSpacing: 2.0,
                    fontFamily: "Pacifico",
                  ),
                ),
                new Text("version:v_01_01_01 Beta 1",style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                new Text("creat time: 2019/06/17",style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                new Text("developed by:",style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                new Text("unnamed team - Yudi & Jiawen-Li",style: TextStyle(fontSize: 18.0, color: Colors.black54),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
