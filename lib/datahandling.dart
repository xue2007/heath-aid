import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataHandling {

  getData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance.collection('users').document(user.uid).get();
  }
}