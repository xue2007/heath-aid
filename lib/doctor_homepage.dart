import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/auth_constants.dart';
import 'auth.dart';
import 'database.dart';
import 'helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/patient_status.dart';
import 'auth_provider.dart';
import 'doctor_profile.dart';
import 'chatroom.dart';
import 'myPatient_card.dart';


class AllUsersPage extends StatefulWidget {
  AllUsersPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  static DateTime currentTime = new DateTime.now();
  DataBase databaseMethods = new DataBase();
  Stream profileStream;
  String formattedDate =
      DateFormat('kk:mm:ss \n EEE d MMM').format(currentTime);

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
  void initState(){
  getUserInfo();
    super.initState();

  }
  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getPatients(Constants.myName).then((value) {
      setState(() {
        profileStream = value;
      });
    });
  }
  createProfile() {
    String id = Constants.myName;
    Map<String, dynamic> profileMap = {
      'users':id,
      'name':'',
      'specialisation':'',
      'about':'',
      'expertise':'',
      'address':''
    };
    databaseMethods.createDoctorProfile(id, profileMap);
    databaseMethods.createDoctorDocuments(id, profileMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Doctor Homepage'),
        centerTitle: true,
      ),
      body: _buildBody(context),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
               accountName: new Text(Constants.myName),
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

                Firestore.instance.collection('Doctor').document(Constants.myName).get().then((exist) {
                  if(!exist.exists) {
                    createProfile();
                  }
                });


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

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 50,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/doctorCartoon.jpg",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 222,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            " Welcome Doctor " +Constants.myName,
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          /*Text(
                            "Heart and kidney Specialist",
                            style: TextStyle(fontSize: 19, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.message),
                                color: Colors.orange,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) => new ChatRoom()));
                                },
                              ),
                              IconButton(
                                color: Colors.lightGreenAccent,
                                icon: Icon(Icons.call),
                                onPressed: (){
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.video_call),
                                onPressed: (){
                                },
                              ),
                            ],
                          )*/
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(),
                  ],
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40))),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: ListView(
                children: <Widget>[
                  Text(
                    'My Patients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildCard(context, child: PatientCard()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Patients Currently',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildCard(context,
                      child: NotificationCard(
                        name: 'Patient1',
                        illness: 'Diabetes',
                        time: formattedDate,
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCard(context, {Widget child}) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular((10))),
      ),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
  Widget chatRoomList() {
    return StreamBuilder(
      stream: profileStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return NotificationCard(
                  name:snapshot.data.documents[index].data['chatRoomId']
                      .toString()
                      .replaceAll('_', '')
                      .replaceAll(Constants.myName, ''),
                  illness:
                  snapshot.data.documents[index].data['age'],
                time:formattedDate
                ,);
            })
            : Container();
      },
    );
  }
}


class NotificationCard extends StatelessWidget {

  final String name;
  final String illness;
  final String time;
  const NotificationCard({
    Key key, this.name,this.illness,this.time
  }) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left:2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/cool1.jpg'),
                      )
                  ),
                ),
                Container(
                  width: 100,
                  child: ListTile(
                    title: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(illness),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.check_circle,
                      size: 30,
                      color: Colors.green,
                    ),
                    IconButton(
                      icon:Icon(Icons.add),
                      iconSize: 30,
                      color: Colors.orange,
                      onPressed: (){
                      },
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}
