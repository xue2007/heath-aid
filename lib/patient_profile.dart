import 'package:flutter/material.dart';

import 'chatroom.dart';
import 'database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'helper.dart';
import 'auth_constants.dart';
import 'package:testing/EditPatient.dart';

class PatientProfile extends StatefulWidget {
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Patient Profile'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new EditPatient()));
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  DataBase databaseMethods = new DataBase();
  Stream<QuerySnapshot> profileStream;


  Widget _buildBody(BuildContext context ){
    return StreamBuilder (
      stream: profileStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? Column(
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
                                   snapshot.data.documents[0]['name'],
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
                                       snapshot.data.documents[0]['age'] ,
                                    style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                     ' Yrs',
                                    style: TextStyle(fontSize: 12,color: Colors.white),
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
                                    snapshot.data.documents[0]['weight'] ,
                                    style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " KG ",
                                    style: TextStyle(fontSize: 12,color: Colors.white),

                                  ),
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
                                   snapshot.data.documents[0]['fat'] ,
                                    style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " % ",
                                    style: TextStyle(fontSize: 12,color: Colors.white),

                                  ),
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
                                  snapshot.data.documents[0]['height'] ,
                                    style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " cm ",
                                    style: TextStyle(fontSize: 12,color: Colors.white),

                                  ),
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
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        _buildPatient(' Blood \n Pressure',   snapshot.data.documents[0]['bloodPressure'] , ' vmm/Hg',const Color(0xffff2e6a)),
        _buildPatient(' Heart \n Beat', snapshot.data.documents[0]['heartBeat'] ,' per min',const Color(0xff1250f3)),
        _buildPatient(' Blood \n Glucose',  snapshot.data.documents[0]['bloodGlucose']  , ' mg/dl',const Color(0xff14d083)),
        ],
        ),
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
                          child: Container(
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
                                            'name',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text('illness'),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'time',
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
                          ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ) : CircularProgressIndicator;
      }
    );

  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    //Firestore.instance.collection('Patient').document(Constants.myName).get().then((exist) {exist.exists ? ok = true : ok = false;});
    databaseMethods.getPatientInfo(Constants.myName).then((value) {
      setState(() {
        profileStream = value;
      });
    });
  }

  Widget _buildPatient(String title,String subtitle,String symbol,var color){
    return Flexible(
      flex: 5,
      child: Card(
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color:color,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 0,
                  child: CustomPaint(
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          symbol,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
