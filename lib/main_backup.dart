import 'package:FirstWeb/top_navigation_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// void main() {
//   runApp(MyApp());
// }

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
  final myName = TextEditingController();
  final myText = TextEditingController();
  final myPremium = TextEditingController();
  final myAge = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: ListView(
            children: <Widget>[
              NavigationBar(),

              ///Number 1
              GetData(myText: myText),

              ///Number 2
              SetData(myName: myName, myAge: myAge),
              MadebyAnim()
            ],
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

class SetData extends StatefulWidget {
  const SetData({
    Key key,
    @required this.myName,
    @required this.myAge,
  }) : super(key: key);

  final TextEditingController myName;
  final TextEditingController myAge;

  @override
  _SetDataState createState() => _SetDataState();
}

class _SetDataState extends State<SetData> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
                alignment: Alignment.center,
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("Users").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new SpinKitFoldingCube(
                            color: Colors.red,
                            duration: Duration(seconds: 5),
                          );
                        default:
                          return Column(
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 300,
                                child: TextFormField(
                                  decoration: new InputDecoration.collapsed(
                                    hintText: 'New Name',
                                    hoverColor: Colors.red,
                                    fillColor: Colors.black12,
                                  ),
                                  cursorColor: Colors.red,
                                  maxLines: 2,
                                  enabled: true,
                                  controller: widget.myName,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 300,
                                child: TextFormField(
                                  decoration: new InputDecoration.collapsed(
                                    hintText: 'New Age',
                                  ),
                                  cursorColor: Colors.red,
                                  maxLines: 2,
                                  enabled: true,
                                  controller: widget.myAge,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  String data = "";
                                  setState(() {
                                    Firestore.instance
                                        .collection('Users')
                                        .document("WTwAWTnQGb0HUMDZIDAJ")
                                        .setData({
                                      'Name': widget.myName.text.toString(),
                                      'Age': widget.myAge.text.toString(),
                                      'Premium': true,
                                    });
                                  });
                                  print(data);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.red,
                                  elevation: 10,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: 300,
                                    child: Text(
                                      "Set that data..!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                      }
                    })),
          ],
        ),
        CardView2(),
      ],
    ));
  }
}

class GetData extends StatefulWidget {
  const GetData({
    Key key,
    @required this.myText,
  }) : super(key: key);

  final TextEditingController myText;

  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: <Widget>[
        CardView(),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.red,
                    elevation: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 300,
                      child: Text(
                        "Get that data..!",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("Users").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new SpinKitFoldingCube(color: Colors.red);
                        default:
                          return Column(
                            children: <Widget>[
                              ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                padding: EdgeInsets.all(5.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return new Card(
                                    child: Text(snapshot
                                        .data.documents[index].data["Name"]),
                                  );
                                },
                              ),
                              TextFormField(
                                cursorColor: Colors.red,
                                maxLines: 2,
                                enabled: true,
                                controller: widget.myText,
                              )
                            ],
                          );
                      }
                    }),
              ],
            )),
      ],
    ));
  }
}

class CardView extends StatelessWidget {
  String syntax =
      "\t\t\t\t\tFirebaseDatabase.instance.reference()\n.child('Users')\t\t\n.set({\t\t\n\t'Name':Tony\n\t'Worth': 100\n});\t\t\t";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 650,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Get Data Command",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                height: 0.9,
                fontFamily: 'Open Sans',
                fontSize: 60,
                color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Firestore Uses NoSQL",
            style: TextStyle(
              fontSize: 21,
              height: 1.7,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class CardView2 extends StatelessWidget {
  String syntax =
      "\t\t\t\t\tFirebaseDatabase.instance.reference()\n.child('Users')\t\t\n.set({\t\t\n\t'Name':Tony\n\t'Worth': 100\n});\t\t\t";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 650,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Set Data Command",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                height: 0.9,
                fontFamily: 'Open Sans',
                fontSize: 60,
                color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Set Information of First User(Bruce)",
            style: TextStyle(
              fontSize: 21,
              height: 1.7,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
