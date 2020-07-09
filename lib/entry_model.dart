import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Entry {
  String date;
  int bloodPressure;
  int bloodSugar;
  int heartRate;

  DocumentReference reference;

  Entry(this.date, {this.bloodPressure, this.bloodSugar, this.heartRate});

  factory Entry.fromJson(Map<dynamic, dynamic> json) => _EntryFromJson(json);

  Map<String, dynamic> toJson() => _EntryToJson(this);
  @override
  String toString() => "Entry on <$date>";
}

Entry _EntryFromJson(Map<dynamic, dynamic> json) {
  return Entry(
    json['Date'] as String,
    bloodPressure: json['Blood Pressure'] as int,
    bloodSugar: json['Blood Sugar'] as int,
    heartRate: json['Heart Rate'] as int,
  );
}

Map<String, dynamic> _EntryToJson(Entry instance) => <String, dynamic>{
      'Date': instance.date,
      'Blood Pressure': instance.bloodPressure,
      'Blood Sugar': instance.bloodSugar,
      'Heart Rate': instance.heartRate,
    };
