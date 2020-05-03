import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'services/crud.dart';

class SetData extends StatefulWidget {
  const SetData({
    Key key,
  }) : super(key: key);

  @override
  _SetDataState createState() => _SetDataState();
}

class _SetDataState extends State<SetData> {
  Future<bool> updateDialog(BuildContext context, selectedDoc) async {
    String username = "";
    String age = "";
    bool premium = true;
    crudMedthods crudObj = crudMedthods();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          print(premium);
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Enter the Data', style: TextStyle(fontSize: 15.0)),
                  GestureDetector(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              content: Container(
                height: 200.0,
                width: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      enableSuggestions: true,
                      decoration: InputDecoration(hintText: 'New Name'),
                      cursorColor: Colors.red,
                      onChanged: (value) {
                        username = value;
                      },
                    ),
                    SizedBox(height: 5.0),
                    TextField(
                      enableSuggestions: true,
                      smartQuotesType: SmartQuotesType.enabled,
                      decoration: InputDecoration(hintText: 'New Age'),
                      cursorColor: Colors.red,
                      onChanged: (value) {
                        age = value;
                      },
                    ),
                    SizedBox(height: 5.0),
                    ListTile(
                      leading: premium ? Text("Premium") : Text("Not Premium"),
                      trailing: premium
                          ? Icon(
                              Icons.bubble_chart,
                              color: Colors.yellow[500],
                            )
                          : Icon(
                              Icons.blur_circular,
                              color: Colors.red,
                            ),
                      onTap: () {
                        setState(() {});
                        premium = !premium;
                      },
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Update'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                    crudObj.updateData(selectedDoc, {
                      'Name': username,
                      'Age': age,
                      'Premium': premium
                    }).catchError((e) {
                      print(e);
                    });
                  },
                )
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(40),
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 10,
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  height: 200,
                  width: 400,
                  child: StreamBuilder<QuerySnapshot>(
                      stream:
                          Firestore.instance.collection("Users").snapshots(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new SpinKitFoldingCube(color: Colors.red);
                          default:
                            return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                String name = snapshot
                                    .data.documents[index].data["Name"]
                                    .toString();
                                String age = "Age:" +
                                    snapshot.data.documents[index].data["Age"]
                                        .toString();
                                bool premium = snapshot
                                    .data.documents[index].data["Premium"];
                                return new ListTile(
                                  leading: Text("Name"),
                                  trailing: premium
                                      ? Icon(
                                          Icons.bubble_chart,
                                          color: Colors.yellow[500],
                                        )
                                      : Icon(
                                          Icons.blur_circular,
                                          color: Colors.red,
                                        ),
                                  title: Text(name),
                                  subtitle: Text(age),
                                  onTap: () {
                                    updateDialog(
                                        context,
                                        snapshot
                                            .data.documents[index].documentID);
                                  },
                                );
                              },
                            );
                        }
                      }),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    print("Down");
                    setState(() {});
                  },
                  child: Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blue,
                  splashColor: Colors.redAccent[300],
                ),
              )
            ],
          ),
          CardView2()
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
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Set Data",
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
            "Select the user to Update data",
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
