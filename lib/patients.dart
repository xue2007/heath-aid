import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/entry_model.dart';

class Patient {
  String name;
  int age;
  String address;
  String type;
  String notes;
  //This links to the patient's health record
  List<Entry> entries = List<Entry>();
  //Creating a document reference
  DocumentReference reference;
  //Constructor (name is compulsory), the rest are optional
  Patient(this.name,
      {this.age, this.address, this.entries, this.type, this.notes});
  //factory constructor to create Patient from a Firestore DocumentSnapshot
  factory Patient.fromSnapshot(DocumentSnapshot snapshot) {
    Patient newPatient = Patient.fromJson(snapshot.data);
    newPatient.reference = snapshot.reference;
    return newPatient;
  }
  //factory constructor to create Patient from Json
  factory Patient.fromJson(Map<String, dynamic> json) => _PatientFromJson(json);
  // Turn patient into a key/value pair
  Map<String, dynamic> toJson() => _PatientToJson(this);
  @override
  String toString() => "Patient<$name>";
}

//Function to convert a map of key/value pair into a Patient
Patient _PatientFromJson(Map<String, dynamic> json) {
  return Patient(json['Name'] as String,
      age: json['Age'] as int,
      address: json['Address'] as String,
      type: json["Type"] as String,
      notes: json["Notes"] as String,
      entries: _convertEntries(json['health-entries'] as List));
}

//Turn another map of key/value pairs into a list of Entry
List<Entry> _convertEntries(List entryMap) {
  if (entryMap == null) {
    return null;
  }
  List<Entry> entries = List<Entry>();
  entryMap.forEach((value) {
    entries.add(Entry.fromJson(value));
  });
  return entries;
}

//Convert a Patient into a map of key/value pair
Map<String, dynamic> _PatientToJson(Patient instance) => <String, dynamic>{
      'Name': instance.name,
      'age': instance.age,
      'Address': instance.address,
      'Type': instance.type,
      'Notes': instance.notes,
      'health-entries': _EntryList(instance.entries),
    };
//Convert a list of entries into a list of mapped key/value pair
List<Map<String, dynamic>> _EntryList(List<Entry> entries) {
  if (entries == null) {
    return null;
  }
  List<Map<String, dynamic>> entryMap = List<Map<String, dynamic>>();
  entries.forEach((entry) {
    entryMap.add(entry.toJson());
  });
  return entryMap;
}
