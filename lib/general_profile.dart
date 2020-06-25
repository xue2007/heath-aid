import 'package:flutter/material.dart';



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:IconButton(
          icon:Icon(Icons.arrow_left,size: 60.0,),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        title:Text('Edit Profile'),
      ),
      body: Builder(
        builder: (context) => Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child:CircleAvatar(
                      radius:100.0,
                      backgroundColor: Colors.blue,
                      child: ClipOval(
                        child: SizedBox(
                          width:180.0,
                          height:180.0,
                          child:Image.network('https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80',
                          fit:BoxFit.fill,
                          ),
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:60.0),
                    child:IconButton(
                      icon:Icon(
                        Icons.camera,
                        size:60.0,
                      ),
                      onPressed: () {

                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height:20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(alignment:Alignment.centerLeft,
                          child:Text('Name',
                            style:TextStyle(
                              color: Colors.blueGrey,fontSize: 18.0),
                            ),
                          ),
                      Align(alignment: Alignment.centerLeft,
                        child:Text('bob',
                        style: TextStyle(
                          color:Colors.black,
                            fontSize:20.0,
                        ),
                        ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child:Container(
                      child: Icon (
                        Icons.pan_tool,
                      ),
                    ),
                  ),
                ],
              ),
                ],
              )
          ),
        ),
      );
  }
}

