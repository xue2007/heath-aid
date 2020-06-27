import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testing/Constants.dart';
import 'package:testing/conversation_screen.dart';
import 'database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DataBase databaseMethods = new DataBase();
  TextEditingController searchForController = new TextEditingController();
  QuerySnapshot searchSnapshot;

  Widget searchList() {
    return searchSnapshot !=null ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return searchTile(
            name: searchSnapshot.documents[index].data['name'],
            email: searchSnapshot.documents[index].data['email'],
          );

        }) : Container();
  }
  startSearch() {
    databaseMethods.getUserByUsername(searchForController.text)
        .then((val) {
          setState(() {
            searchSnapshot = val;
          });
    });
  }
  createChat(String user1) {
    if(user1 != Constants.myName) {
      String chatRoomId = getChatRoomId(user1, Constants.myName);
      List<String> users = [user1, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatRoomId': chatRoomId
      };
      databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId
          )
      ));
    } else {
      print('you cannot send message to yourself');
    }
  }
  Widget searchTile({String name,
   String email}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,),
              Text(email, )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChat(name);

            },
            child: Container(
              decoration: BoxDecoration(
                  color:Colors.blue,
                  borderRadius: BorderRadius.circular(30)
              ),
              padding:EdgeInsets.symmetric(horizontal:16, vertical: 8),
              child:Text('message',),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
           title: Text('Chat'),
          ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 24,vertical:16),
              child: Row(
              children :[
              Expanded(
                  child: TextField(
                    controller: searchForController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "search username...",
                      hintStyle: TextStyle(
                        color:Colors.white
                      ),
                      border:InputBorder.none
                    ),
                  )
              ),
              GestureDetector(
                onTap: () {
                  startSearch();
                },
                child: Container(
                  height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0x36FFFFFF),
                          const Color(0x0FFFFFFF)
                        ]
                      )
                    ),
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/search_white.png')
                ),
              ),
          ],
        ),
            ),
            searchList()
    ],
        ),
      ),
    );
  }
}


getChatRoomId(String first, String second) {
  if(first.substring(0,1).codeUnitAt(0) > second.substring(0,1).codeUnitAt(0)) {
    return '$second\_$first';
  } else {
    return '$first \_$second';
  }
}

