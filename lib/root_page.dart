import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/Constants.dart';
import 'package:testing/doctor_homepage.dart';
import 'auth.dart';
import 'auth_provider.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStates {
  firstPage, signedIn, signedInDoctor,notDetermined
}

class _RootPageState extends State<RootPage> {
  AuthStates authStatus = AuthStates.firstPage;

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
 /*@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      auth.currentUser().then((id) {
        print("AuthStatus is now ${authStatus.toString()}");
        setState(() {
          //authStatus = id == null ? AuthStates.firstPage : AuthStates.signedIn;

            if (Constants.checkRole == true) {
              authStatus = AuthStates.signedInDoctor;
            } else {
              authStatus = AuthStates.signedIn;
              print('$id');
            }

        });
      });
    } catch (e) {}
  }
*/

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStates.firstPage:
        return LoginPage(
          //auth: widget.auth,
          onSignedIn: Constants.checkRole == true ? _signedInDoctor : _signedIn,
        );
      case AuthStates.signedIn:
        return HomePage(
          //auth: widget.auth,
          onSignedOut: _signedOut,
        );
      case AuthStates.signedInDoctor:
        return AllUsersPage(
          //auth: widget.auth,
          onSignedOut: _signedOut,
        );
      case AuthStates.notDetermined:
        return _buildWaitingScreen();
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}


