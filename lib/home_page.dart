import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/Constants.dart';

import 'package:testing/chatroom.dart';
import 'package:testing/data_upload_page.dart';
import 'package:testing/doctor_homepage.dart';
import 'package:testing/login_page.dart';
import 'package:testing/user_profile.dart';
import 'auth.dart';
import 'auth_provider.dart';
var globalContext;
class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DateTime currentTime = new DateTime.now();
  String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(currentTime);
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
              //accountName: new Text(Constants.myName),
              //accountEmail: new Text('bye'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage('assets/patientCartoon.jpg'),
                child: Text('hi'),
                backgroundColor: Colors.greenAccent,
              ),
            ),
            new ListTile(
              title: new Text('My Health Record'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new RecordPage()));
              },
            ),
            new ListTile(
              title: new Text('Chatroom'),
              onTap: () {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color:Colors.grey,
                ),
              ),
              color: Colors.orange,
            ),
            padding: EdgeInsets.only(left:20,bottom :20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Welcome',
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ) ,
                ),
                SizedBox(width: 120,),
                //SizedBox(width: 50,),
                RaisedButton.icon(
                  label: Text('upload Health Data'),
                    icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: (){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new HealthForm()));
                  },
                )
              ],
            ),
          ),

          SizedBox(height: 10,),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Doctor Appointments'),
                  Container(
                    height:200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        AppointmentCard(),
                        AppointmentCard(),
                      ],
                    ),
                  ),
                  SizedBox(height:10),
                  Text('My Medication'),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: MedicineContainer(
                            active: true,
                            time: 'Morning',
                          ),
                      ),
                      SizedBox(width:10),
                      Expanded(
                        child: MedicineContainer(
                          active: false,
                          time: 'Afternoon',
                        ),
                      ),
            ],
          ),
                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MedicineContainer(
                              active: false,
                              time: 'Evening',
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: MedicineContainer(
                              active: false,
                              time: 'Night',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:5),
                  Text('Recent'),
                  SizedBox(height: 5,),
                  Expanded(
                    child: ListView(
                      //scrollDirection: Axis.vertical,
                      children: <Widget>[
                        MessagesCard(
                          color: Colors.blue,
                          icon:Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ),
                        MessagesCard(
                          color: Colors.blue,
                          icon:Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      ),
                    ),
                  ],
    ),
    ),
          ),
        ],
      ),

    );

  }
}



class MedicineContainer extends StatelessWidget {
  final String time;
  final bool active;
  const MedicineContainer({Key key, this.time, this.active}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 3.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              time,
              style: TextStyle(
                  color: active ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.block,
                  color: Colors.yellow,
                ),
                active
                    ? Container()
                    : Icon(
                  Icons.block,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class AppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(11.0),
      padding: EdgeInsets.all(15.0),
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Consulting Doctor"),
          SizedBox(
            height: 20,
          ),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/health.jpg',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Doctor",
                      style: TextStyle(fontSize: 23, color: Colors.blueAccent),
                    ),
                    Text(
                      "Clinical Medicine",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Monday",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "12:00PM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class MessagesCard extends StatelessWidget {
  final Color color;
  final Icon icon;
  const MessagesCard({Key key, this.color, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 3.0, offset: Offset(0,1))]
      ),
      margin: EdgeInsets.symmetric(vertical: 11.0, horizontal: 5.0),
      padding: EdgeInsets.all(11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: icon,
          ),
          SizedBox(
            width: 21,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Appointment Reminder",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    Spacer(),
                    Text('11:00pm'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "You have an appointment with Doctor Brains ",
                        overflow: TextOverflow.ellipsis,
                        //softWrap: true,
                      ),
                    ),
                    //Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}