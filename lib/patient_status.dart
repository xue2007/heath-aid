import 'package:flutter/material.dart';
import 'package:testing/patient_profile.dart';
import 'package:testing/SearchPatient.dart';
import 'auth_constants.dart';
import 'helper.dart';
import 'database.dart';
import 'DoctorPatient.dart';



class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  ScrollController _scrollController;
  DataBase databaseMethods = new DataBase();
  Stream profileStream;
@override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
  _scrollController = new ScrollController();
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
  Widget chatRoomList() {
    return StreamBuilder(
      stream: profileStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                  snapshot.data.documents[index].data['chatRoomId']
                      .toString()
                      .replaceAll('_', '')
                      .replaceAll(Constants.myName, ''),
                  snapshot.data.documents[index].data['chatRoomId']);
            })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        body:NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext contest, bool innerbox){
            return <Widget>[
              SliverAppBar(
                leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            }
            ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => new SearchPatient()));
                  },
                    icon: Icon(Icons.search),

                  ),
                  //Container(width:10.0,),
                  IconButton(onPressed: (){

                  },icon: Icon(Icons.more_vert),)
                ],
                pinned: true,
                floating: true,
                centerTitle: true,
                backgroundColor: Colors.blueAccent,
                title: Text('Patient Status'),
                bottom:TabBar(
                  indicatorWeight: 4.0,
                  indicatorColor: Colors.white,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: 'Patient',
                    ),
                    /*Tab(
                      text:'Checked',
                    ),*/
                    Tab(
                      text: 'Favourite',
                    ),
                  ]
                )
              )
            ];
          },
          body: TabBarView(
            controller:  _tabController,
            children: [
              chatRoomList(),
              //Text('Patient'),
              Text('Favourite'),
            ],
          ),
        ),
      ),
    );
  }
}
class ChatRoomsTile extends StatelessWidget {
  final String name;
  final String chatRoomId;
  ChatRoomsTile(this.name, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorPatient(name)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: Text(
                name.substring(0, 1),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(name)
          ],
        ),
      ),
    );
  }
}










/*

class PatientInformation extends StatefulWidget {

  PatientInformationState createState() => PatientInformationState();


}
class PatientInformationState extends State<PatientInformation> {

  List<String> names = [
   'a',
   'b',
   'c',
 ];
 List<String> text = [
   'hello',
   'bye',
   'yo'
 ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: names.length,
      itemBuilder:(context,index){
        return GestureDetector(
          onTap:(){ Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new PatientProfile()));
          },
          child: ListTile(
            leading: CircleAvatar(
              child:Text('hi'),
            ),
            title: Text(names [index]),
            subtitle: Text(text[index]),
            trailing: Text('11:00 AM')
          ),
        );
  });

  }
  
}*/
