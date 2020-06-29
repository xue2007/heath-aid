import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/Constants.dart';
import 'auth.dart';

import 'package:testing/patient_status.dart';
import 'auth_provider.dart';
import 'general_profile.dart';
import 'chatroom.dart';
import 'myPatient_card.dart';
import 'notification_card.dart';


class AllUsersPage extends StatefulWidget {
  AllUsersPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  static DateTime currentTime = new DateTime.now();
  String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(currentTime);

  void _signOut() async{
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
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
      body: _buildBody(context),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
             // accountName: new Text(Constants.myName),
              //accountEmail: new Text('bye'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage('assets/doctorCartoon.jpg'),
                child: Text('P'),
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
            /*new ListTile(
              title: new Text('Doctors'),
              onTap: () {
                Auth().authorizeAccess(context);
              },
            ),*/
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
              title: new Text('Profile'),
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Profile()));
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
  Widget _buildBody(BuildContext context ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex:2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40)
              )
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,15,10,10),
              child: ListView(
                children: <Widget>[
                  Text(
                    'My Patients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height:10),
                  _buildCard(context,child: PatientCard()),
                  SizedBox(height: 10,),
                  Text(
                    'Medication Reminders',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  _buildCard(context,
                    child: NotificationCard(
                      name: 'Patient1',
                      illness: 'Diabetes',
                      time: formattedDate,
                    )
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );

  }

  Widget _buildCard(context,{Widget child}) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular((10))
        ),
      ),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );

  }
}
