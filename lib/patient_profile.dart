import 'package:flutter/material.dart';

import 'chatroom.dart';
import 'myPatient_card.dart';
import 'notification_card.dart';

class PatientProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Patient Profile'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex:2,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:<Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius:  30,
                          child: ClipOval(
                            child: Image.asset("assets/patientCartoon.jpg",),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 222,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 40,),
                          Text(
                            " Patient",
                            style: TextStyle(fontSize: 20,color: Colors.white),

                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              Container(
                                decoration:BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white,width: 2)

                          ),
                                child: IconButton(
                                  icon: Icon(Icons.message),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) => new ChatRoom()));
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                 // borderRadius: BorderRadius.circular(50),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white,width:2 )
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.call),
                                  onPressed: (){
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(50),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white,width:2 )
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.video_call),
                                  onPressed: (){
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                              " Age:",
                              style: TextStyle(fontSize: 12,color: Colors.white),
                            ),
                              Text(
                                " 68 Yrs",
                                style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                      ],
                          ),

                          SizedBox(height: 15,),
                          Row(
                            children: <Widget>[
                              Text(
                                " Weight: ",
                                style: TextStyle(fontSize: 12,color: Colors.white),

                              ),
                              Text(
                                '56KG',
                                style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: <Widget>[
                              Text(
                                " Fat: ",
                                style: TextStyle(fontSize: 12,color: Colors.white),

                              ),
                              Text(
                                '5.8%',
                                style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: <Widget>[
                              Text(
                                " Height: ",
                                style: TextStyle(fontSize: 12,color: Colors.white),

                              ),
                              Text(
                                '175cm',
                                style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),
                              )
                            ],
                          ),

                        ],

                      ),

                    ),
                  ],
                ),
              ],
            ),
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
          flex: 4,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,15,10,10),
              child: ListView(
                children: <Widget>[
                 /* Text(
                    'Pulse',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
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
                        time: '10pm',
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
    return Container(
     /* elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular((10))
        ),
      ),*/
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );

  }
}
