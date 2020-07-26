import 'package:cloud_firestore/cloud_firestore.dart';
class DataBase {

  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

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
  Future<void> createDoctorProfile(String id,profileMap){
    Firestore.instance.collection('Doctor')
        .document(id).setData(profileMap).catchError((e){
      print(e.toString());
    });
  }
  Future<bool>createDoctorDocuments(String id,profileMap){
    Firestore.instance.collection('Doctor')
        .document(id)
        .collection('profile')
        .document(id)
        .setData(profileMap).catchError((e){
      print(e.toString());
    });
  }
  Future<void> createPatientProfile(String id,profileMap){
    Firestore.instance.collection('Patient')
        .document(id).setData(profileMap).catchError((e){
      print(e.toString());
    });
  }
  Future<bool>createPatientDocuments(String id,profileMap){
    Firestore.instance.collection('Patient')
        .document(id)
        .collection('profile')
        .document(id)
        .setData(profileMap).catchError((e){
      print(e.toString());
    });
  }


  Future<bool> createChatRoom(String id,chatRoomMap) {
    Firestore.instance.collection('Chatroom')
        .document(id).setData(chatRoomMap).catchError((e) {
        print(e.toString());
    });
  }
  Future<bool> createProfileRoom(String id,chatRoomMap) {
    Firestore.instance.collection('DoctorPatient')
        .document(id).setData(chatRoomMap).catchError((e) {
      print(e.toString());
    });
  }


  Future<void> addConversationMessages(String roomId, messageMap){
    Firestore.instance.collection('Chatroom')
        .document(roomId)
        .collection('chats')
        .add(messageMap).catchError((e){print(e.toString());});
  }
  getConversationMessages(String roomId) async {
    return await Firestore.instance.collection('Chatroom')
        .document(roomId)
        .collection('chats')
        .orderBy('time',descending: false)
        .snapshots();
  }
  getDoctorInfo(String id) async {
    return await Firestore.instance.collection('Doctor')
        .document(id).collection('profile')
        .snapshots();
  }
  getPatientInfo(String id) async {
    return await Firestore.instance.collection('Patient')
        .document(id).collection('profile')
        .snapshots();
  }
  getPatients(String id) async {
    return await Firestore.instance.collection('DoctorPatient')
        .where('users',arrayContains: id)
        .snapshots();
  }


  getChatRooms(String id) async{
    return await Firestore.instance
        .collection("Chatroom")
        .where('users',arrayContains: id)
        .snapshots();
  }

}