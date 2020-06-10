import'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'adminonly.dart';
import 'package:flutter/widgets.dart';

abstract class BaseAuth{
  Future<String> signInWithEmailAndPassWord(String email, String password);
  Future<String> createUserWithEmailAndPassWord(String email,String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {

  Future<String> signInWithEmailAndPassWord(String email, String password) async {
    FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }
  Future<String> createUserWithEmailAndPassWord(String email,String password) async {
    FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }
  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
}
  authorizeAccess(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('/users')
          .where('uid',isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if(docs.documents[0].exists) {
          if(docs.documents[0].data['role'] == 'doctor') {
            Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new AdminPage()));
          } else {
            print('Not Authorized');
          }
        }
      });
    });
  }

}