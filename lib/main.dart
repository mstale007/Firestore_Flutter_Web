//import 'package:FirstWeb/services/crud.dart';
import 'package:FirstWeb/adddart.dart';
import 'package:FirstWeb/deletedata.dart';
import 'package:FirstWeb/distinctdata.dart';
import 'package:FirstWeb/takedart.dart';
import 'package:FirstWeb/top_navigation_bar.dart';
import 'package:FirstWeb/wheredata.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'getdata.dart';
import 'setdata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: 'Open Sans')),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1500),
            child: ListView(
              children: <Widget>[
                NavigationBar(),
                GetData(),
                SetData(),
                AddData(),
                DeleteData(),
                WhereData(),
                LimitData(),
                DistinctData(),
                MadebyAnim()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MadebyAnim extends StatelessWidget {
  const MadebyAnim({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(width: 20.0, height: 100.0),
        Text(
          "Made by",
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w800),
        ),
        SizedBox(width: 20.0, height: 100.0),
        RotateAnimatedTextKit(
            onTap: () {
              print("Tap Event");
            },
            text: [
              "MIHIR TALE",
              "SOHAM BHURE",
              "TANYA AGRAWAL",
              "GANESH TARONE"
            ],
            textStyle: TextStyle(
                fontSize: 40.0, fontFamily: "Horizon", color: Colors.white),
            textAlign: TextAlign.start,
            alignment: AlignmentDirectional.topStart // or Alignment.topLeft
            ),
      ],
    );
  }
}
