import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:testing/datahandling.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'datahandling.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Patient Health Entries'),
            backgroundColor: Colors.blue,
            centerTitle: true),
        body: DataTable(columns: [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Blood Sugar')),
          DataColumn(label: Text('B.P')),
          DataColumn(label: Text('H.Rate')),
        ], rows: [
          DataRow(cells: [
            DataCell(Text('2020-6-10')),
            DataCell(Text('94')),
            DataCell(Text('116')),
            DataCell(Text('98')),
          ])
        ]),
      ),
    );
  }
}
