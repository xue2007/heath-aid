import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/doctor_homepage.dart';
import 'auth.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStates { firstPage, signedIn, signedInDoctor }

class _RootPageState extends State<RootPage> {
  AuthStates authStatus = AuthStates.firstPage;
  bool doctor;
  bool checkDoctor() {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          print('checked');
          if (docs.documents[0].data['role'] == 'doctor') {
            doctor = true;
            print('doctor is true');
          } else {
            doctor = false;
            print('doctor is false');
          }
        }
      });
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentUser().then((id) {
      setState(() {
        //authStatus = id == null ? AuthStates.firstPage : AuthStates.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStates.signedIn;
    });
  }

  void _signedInDoctor() {
    setState(() {
      authStatus = AuthStates.signedInDoctor;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStates.firstPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    checkDoctor();
    switch (authStatus) {
      case AuthStates.firstPage:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: doctor == true ? _signedInDoctor : _signedIn,
        );
      case AuthStates.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
      case AuthStates.signedInDoctor:
        return new AllUsersPage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}
