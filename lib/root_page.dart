import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'login_page.dart';
import 'home_page.dart';


class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();

}

enum AuthStates {
  firstPage,
  signedIn
}

class _RootPageState extends State<RootPage> {
  AuthStates authStatus = AuthStates.firstPage;

  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentUser().then((id){
      setState(() {
        //authStatus = id == null ? AuthStates.firstPage : AuthStates.signedIn;
      });
    });

  }

  void _signedIn(){
  setState(() {
    authStatus = AuthStates.signedIn;
  });
  }
  void _signedOut() {
    setState(() {
      authStatus = AuthStates.firstPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus) {
      case AuthStates.firstPage:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,

        );
      case AuthStates.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }

  }
}