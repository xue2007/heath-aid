import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testing/Constants.dart';
import 'package:testing/database.dart';

class ConversationScreen extends StatefulWidget {
  final String roomId;
  ConversationScreen(this.roomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DataBase databaseMethods = new DataBase();
  TextEditingController messageController = new TextEditingController();
  Stream<QuerySnapshot> chatMessageStream;

  Widget chatMessageList() {
    return StreamBuilder(
      stream:chatMessageStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index) {
              return MessageTile(
                  message:snapshot.data.documents[index].data['message'],
                  sendByMe: snapshot.data.documents[index].data['sendBy'] == Constants.myName
              );
            }) : Container();
      },
    );
  }


  sendMessage() {
    if(messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text,
        'sendBy': Constants.myName,
        'time' : DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.roomId,messageMap);
      setState(() {
        messageController.text = '';
      });

    }
  }
  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.roomId).then((value){
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Chat'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            chatMessageList(),

            Container(
              alignment: Alignment.bottomCenter,

              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              //color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16,vertical:10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                color: Colors.grey,
                child: Row(
                  children :[
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(
                                  color:Colors.white
                              ),
                              border:InputBorder.none
                          ),
                        )
                    ),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin:FractionalOffset.topLeft,
                                  end:FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset('assets/send.png',)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 10 : 24,
          right: sendByMe ? 24 : 10),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ]
                  : [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
