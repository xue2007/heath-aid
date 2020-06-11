import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/chatroom.dart';
import 'package:testing/datahandling.dart';
import 'package:testing/user_profile.dart';
import 'auth.dart';
import 'doctor_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'datahandling.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              //accountName: new Text('hi'),
              //accountEmail: new Text('bye'),
              currentAccountPicture: new CircleAvatar(
                //backgroundImage: NetworkImage('https://images.unsplash.com/photo-1579123480439-dcc379da4707?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
                child: Text('hi'),
                backgroundColor: Colors.greenAccent,
              ),
            ),
            new ListTile(
              title: new Text('My Health Record'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new RecordPage()));
              },
            ),
            new ListTile(
              title: new Text('Chatroom'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ChatRoom()));
              },
            ),
            new ListTile(
              title: new Text('Logout'),
              onTap: _signOut,
            ),
          ],
        ),
      ),
    );
  }
}
