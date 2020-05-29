import 'package:cloud_firestore/cloud_firestore.dart';
import'package:firebase_auth/firebase_auth.dart';

class addingdata {
  Future<void> addData(info) async {
      Firestore.instance.collection('user')
          .add(info)
          .catchError((e){
            print(e);
      });
  }
}