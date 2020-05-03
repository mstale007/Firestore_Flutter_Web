import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WhereData extends StatefulWidget {
  const WhereData({
    Key key,
  }) : super(key: key);

  @override
  _WhereDataState createState() => _WhereDataState();
}

class _WhereDataState extends State<WhereData> {
  @override
  String search_query = "";
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.cyan,
      child: Row(
        children: <Widget>[
          CardView(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 50,
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        enableSuggestions: true,
                        decoration: InputDecoration(
                            hintText: 'Search Name',
                            fillColor: Colors.blueGrey),
                        cursorColor: Colors.red,
                        onChanged: (value) {
                          search_query = value;
                          setState(() {});
                        },
                      ),
                    ],
                  )),
              Card(
                elevation: 10,
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  height: 150,
                  width: 400,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("Users")
                          .where('Name', isEqualTo: search_query)
                          .getDocuments()
                          .asStream(),
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
                    Icons.adjust,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.cyan,
                  splashColor: Colors.redAccent[300],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CardView extends StatelessWidget {
  String syntax =
      "\t\t\t\t\tFirebaseDatabase.instance.reference()\n.child('Users')\t\t\n.set({\t\t\n\t'Name':Tony\n\t'Worth': 100\n});\t\t\t";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: 650,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Search Data",
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
            "Search for the entry",
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
