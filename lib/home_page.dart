import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/Constants.dart';
import 'package:testing/auth_provider.dart';
import 'package:testing/chatroom.dart';
import 'package:testing/data_upload_page.dart';
import 'package:testing/login_page.dart';
import 'package:testing/user_profile.dart';
import 'auth.dart';

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
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
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
              accountName: new Text(Constants.myName),
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
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new HealthForm()));
          },
          child: Text('Upload Health Data', style: TextStyle(fontSize: 20)),
        ),
        SizedBox(height: 30),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => RecordPage()));
          },
          child: Text('View My Health Data', style: TextStyle(fontSize: 20)),
        )
      ])),
    );
  }
}
