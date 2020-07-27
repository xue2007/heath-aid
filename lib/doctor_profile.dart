import 'package:flutter/material.dart';
import 'package:testing/chatroom.dart';
import 'EditDoctor.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'database.dart';
import 'auth_constants.dart';
import 'helper.dart';



class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  DataBase databaseMethods = new DataBase();
  Stream<QuerySnapshot> chatMessageStream;
  //bool ok;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        title: Text('Profile'),
        //elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new EditDoctor()));
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot) {

          return snapshot.hasData ? SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius:  50,
                        child: ClipOval(
                          child: Image.asset("assets/doctorCartoon.jpg",),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 222,
                        height: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                               snapshot.data.documents[0]['name'] ,
                              style: TextStyle(fontSize: 32),
                            ),

                            Text(
                              snapshot.data.documents[0]['specialisation'],
                              style: TextStyle(fontSize: 19, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20,
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    "About",
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    snapshot.data.documents[0]['about'] ,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.location_on),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Address",
                                      style: TextStyle(
                                          color: Colors.black87.withOpacity(0.7),
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width - 268,
                                        child: Text(
                                          snapshot.data.documents[0]['address'],
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.access_time),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Consultations",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black87.withOpacity(0.7),
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width - 268,
                                        child: Text(
                                          'Monday - Friday Open till 7 Pm',
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.book),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Expertise",
                                      style: TextStyle(
                                          color: Colors.black87.withOpacity(0.7),
                                          fontSize: 25),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width - 268,
                                        child: Text(
                                          snapshot.data.documents[0]['expertise'] ,
                                          style: TextStyle(color: Colors.grey),
                                        ))
                                  ],
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Activity",
                    style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                          decoration: BoxDecoration(
                              color: Color(0xffFBB97C),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFCCA9B),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Icon(Icons.list)),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/2 - 130,
                                child: Text(
                                  "List Of Schedule",
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                          decoration: BoxDecoration(
                              color: Color(0xffA5A5A5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Color(0xffBBBBBB),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Icon(Icons.list)),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/2- 130,
                                child: Text(
                                  "List of Patients",
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ) : CircularProgressIndicator;
        }
      )
    );
  }
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getDoctorInfo(Constants.myName).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
  }
}


