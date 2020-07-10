import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'entry_model.dart';
import 'helper.dart';
import 'patients.dart';

class DataRepository {
  //Storing a reference to patients
  final CollectionReference collection =
      Firestore.instance.collection('Patient');
  //Listen for a stream of snapshots
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  //Add a new patient, this returns a new future if waited
  Future<DocumentReference> addPatient(Patient, patient) {
    return collection.add(patient.toJson());
  }

  //Updating the Patient class
  updatePatient(Patient patient) async {
    await collection
        .document(patient.reference.documentID)
        .updateData(patient.toJson());
  }
}
