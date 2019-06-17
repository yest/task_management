import 'dart:async';

import 'package:firebase/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'myTask.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    
    FirebaseUser firebaseUser = await firebaseAuth.signInWithCredential(authCredential);

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => new MainPage(user: firebaseUser, googleSignIn: googleSignIn)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        /*decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/baby_blue.png"),
                fit: BoxFit.cover
            )
        ),*/
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset("img/logo_trans.png", width: 150.0,),
            new Text(
                  "Simple Task",
                  style: new TextStyle(
                    color: Colors.teal,
                    fontSize: 30.0,
                    letterSpacing: 2.0,
                    fontFamily: "Pacifico",
                  ),
                ),
            new Padding(padding: EdgeInsets.only(bottom: 50.0)),
            InkWell(
              onTap: () {
                _signIn();
              },
              child: new Image.asset("img/google_small.png"))
          ],
        ),
      ),
    );
  }
}
