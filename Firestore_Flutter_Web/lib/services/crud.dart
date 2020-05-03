import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class crudMedthods {

  Future<void> addData(carData) async {
      Firestore.instance.collection('Users').add(carData).catchError((e) {
        print(e);
      });
    }

  getData() async {
    return await Firestore.instance.collection('Users').snapshots();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Users')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Users')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
