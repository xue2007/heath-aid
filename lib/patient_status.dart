import 'package:flutter/material.dart';
import 'package:testing/patient_profile.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  ScrollController _scrollController;

  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
  _scrollController = new ScrollController();
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
                  IconButton(onPressed: (){

                  },icon: Icon(Icons.search),),
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
              PatientInformation(),
              //Text('Patient'),
              Text('Favourite'),
            ],
          ),
        ),
      ),
    );
  }
}

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
  
}
