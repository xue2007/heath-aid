import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Entry {
  String entry;
  DateTime date;
  int bloodPressure;
  int bloodSugar;
  int heartRate;
  bool verified;

  DocumentReference reference;

  Entry(this.entry,
      {this.date,
      this.bloodPressure,
      this.bloodSugar,
      this.heartRate,
      this.verified});

  factory Entry.fromJson(Map<dynamic, dynamic> json) => _EntryFromJson(json);

  Map<String, dynamic> toJson() => _EntryToJson(this);
  @override
  String toString() => "Entry<$entry>";
}

Entry _EntryFromJson(Map<dynamic, dynamic> json) {
  return Entry(
    json['entry'] as String,
    date: json['Date'] == null ? null : (json['Date'] as Timestamp).toDate(),
    bloodPressure: json['Blood Pressure'] as int,
    bloodSugar: json['Blood Sugar'] as int,
    heartRate: json['Heart Rate'] as int,
    verified: json['Verified'] as bool,
  );
}

Map<String, dynamic> _EntryToJson(Entry instance) => <String, dynamic>{
      'Entry': instance.entry,
      'Date': instance.date,
      'Blood Pressure': instance.bloodPressure,
      'Blood Sugar': instance.bloodSugar,
      'Heart Rate': instance.heartRate,
      'Verified': instance.verified,
    };
