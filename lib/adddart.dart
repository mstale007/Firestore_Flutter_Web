import 'package:FirstWeb/services/crud.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
  final myName = TextEditingController();
  final myAge = TextEditingController();
}

class _AddDataState extends State<AddData> {
  bool premium = true;
  String name = '', age = '';
  @override
  Widget build(BuildContext context) {
    crudMedthods crudobj = crudMedthods();
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
              Card(
                elevation: 10,
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  height: 160,
                  width: 400,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.grey[100],
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: new InputDecoration.collapsed(
                              hintText: ' New Name',
                              hoverColor: Colors.red,
                              fillColor: Colors.black12,
                              focusColor: Colors.red),
                          cursorColor: Colors.red,
                          maxLines: 1,
                          enabled: true,
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        color: Colors.grey[100],
                        child: TextFormField(
                          decoration: new InputDecoration.collapsed(
                            hintText: ' New Age',
                          ),
                          cursorColor: Colors.red,
                          maxLines: 1,
                          enabled: true,
                          enableSuggestions: true,
                          onChanged: (value) {
                            age = value;
                          },
                        ),
                      ),
                      Container(
                          child: ListTile(
                        title: premium ? Text("Premium") : Text("Not Premium"),
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
                      ))
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    crudobj.addData({
                      'Name': name,
                      "Age": age,
                      "Premium": premium
                    }).then((result) {
                      //dialogTrigger(context);
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  child: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.cyan,
                  splashColor: Colors.blueAccent,
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
            "Add Data",
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
            "Add a new Entry",
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
