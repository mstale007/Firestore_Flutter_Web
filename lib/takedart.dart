import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import 'services/crud.dart';

class LimitData extends StatefulWidget {
  const LimitData({
    Key key,
  }) : super(key: key);

  @override
  _LimitDataState createState() => _LimitDataState();
}

class _LimitDataState extends State<LimitData> {
  int limit=10;
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
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.cyan[50]
                ),
                height: 50,
                alignment: Alignment.center,
                width: 400,
                child: FlutterSlider(
                    values: [20],
                    max: 20,
                    min: 1,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      limit=lowerValue;
                      setState(() {});
                    },
                  ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  height: 170,
                  width: 400,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("Users")
                          .limit(limit)
                          .snapshots(),
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
                                  onTap: () {},
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
            "Limit Data",
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
            "Limit the number of entries",
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
