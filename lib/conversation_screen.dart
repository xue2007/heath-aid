import 'package:flutter/material.dart';
import 'package:testing/Constants.dart';
import 'package:testing/database.dart';
class ConversationScreen extends StatefulWidget {
  String roomId;
  ConversationScreen(this.roomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  Widget ChatMessageList() {
    return StreamBuilder(
      stream:chatMessageStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index) {
            return MessageTile(snapshot.data.documents[index].data['message'],
            snapshot.data.documents[index].data['sendBy'] == Constants.myName);
            }) : Container();
      },
    );
  }
  DataBase databaseMethods = new DataBase();
  TextEditingController messageController = new TextEditingController();
  Stream chatMessageStream;
  sendMessage() {
    if(messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'message': messageController.text,
        'sendBy': Constants.myName,
        'time' : DateTime.now().millisecondsSinceEpoch

      };
      databaseMethods.addConversationMessages(widget.roomId,messageMap);
      messageController.text='';
    }
  }
  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.roomId).then((value){
      chatMessageStream = value;
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
          children: [
            ChatMessageList(),

            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 24,vertical:16),
              child: Row(
                children :[
                  Expanded(
                      child: TextField(
                        //controller: searchForController,
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
                                ]
                            ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Image.asset('assets/send.png')
                    ),
                  ),
                ],
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
  final bool isSendByMe;
  MessageTile(this.message,this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:isSendByMe ? 0:24,right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width ,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child:Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        decoration: BoxDecoration(
        borderRadius: isSendByMe ?
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23),
            ) :
          BorderRadius.only(
          topLeft: Radius.circular(23),
      topRight: Radius.circular(23),
      bottomRight: Radius.circular(23),
      )
        ),
        child: Text(message, style:
        TextStyle(
            color: Colors.white,
            fontSize: 17
        ),),
      ),
    );
  }
}
