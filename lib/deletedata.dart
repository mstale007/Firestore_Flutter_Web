import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'services/crud.dart';

class DeleteData extends StatefulWidget {
  const DeleteData({
    Key key,
  }) : super(key: key);

  @override
  _DeleteDataState createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  Future<bool> deleteDialog(BuildContext context, selectedDoc, name) async {
    crudMedthods crudObj = crudMedthods();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Do you want to delete ' + name + " ?",
                  style: TextStyle(fontSize: 15.0)),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  textColor: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                    crudObj.deleteData(selectedDoc).catchError((e) {});
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  textColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
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
                                    deleteDialog(
                                        context,
                                        snapshot
                                            .data.documents[index].documentID,
                                        name);
                                  },
                                );
                              },
                            );
                        }
                      }),
                ),
              ),
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
            "Delete Data",
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
            "Select the data to be Deleted",
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
