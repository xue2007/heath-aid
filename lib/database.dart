import 'package:cloud_firestore/cloud_firestore.dart';
class DataBase {

  getUserByUsername(String username) async {
    return await Firestore.instance.collection('users')
        .where('name',isEqualTo: username)
        .getDocuments();

  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance.collection('users')
        .where('email',isEqualTo: userEmail)
        .getDocuments();

  }
  createChatRoom(String id,chatRoomMap) {
    Firestore.instance.collection('Chatroom')
        .document(id).setData(chatRoomMap).catchError((e) {
        print(e.toString());
    });
  }
  addConversationMessages(String roomId, messageMap){
    Firestore.instance.collection('ChatRoom')
        .document(roomId)
        .collection('chats')
        .add(messageMap).catchError((e){print(e.toString());});
  }
  getConversationMessages(String roomId) async{
    return await Firestore.instance.collection('ChatRoom')
        .document(roomId)
        .collection('chats')
        .orderBy('time',descending: false)
        .snapshots();
  }
  getChatRooms(String id) async{
    return await Firestore.instance
        .collection("ChatRoom")
        .where('users',arrayContains: id)
        .snapshots();
  }

}