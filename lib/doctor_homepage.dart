import 'package:flutter/material.dart';
import 'package:testing/patient_status.dart';

import 'auth.dart';
import 'chatroom.dart';

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
      appBar: AppBar(
        title: Text('Doctor Homepage'),
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
              title: new Text('My Patient Status'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new PatientPage()));
              },
            ),
            new ListTile(
              title: new Text('Doctors'),
              onTap: () {
                Auth().authorizeAccess(context);
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
