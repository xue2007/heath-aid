import 'package:flutter/material.dart';

import 'auth.dart';

class AllUsersPage extends StatefulWidget {
  AllUsersPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {

  void _signOut() async{
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Doctor'),
      ),
      body: new RaisedButton(
           child: new Text('logout'),
          onPressed: _signOut),
    );
  }
}
