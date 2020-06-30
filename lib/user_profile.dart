import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/home_page.dart';
import 'package:testing/patient_profile.dart';
import 'package:testing/root_page.dart';
//import 'package:testing/datahandling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'datahandling.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Health Entries',
      home: HealthRecordPage(),
    );
  }
}

class HealthRecordPage extends StatefulWidget {
  @override
  _HealthRecordState createState() {
    return _HealthRecordState();
  }
}

class Record {
  final String date;
  final int bloodPressure;
  final int bloodSugar;
  final int heartRate;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Date'] != null),
        assert(map['Blood Pressure'] != null),
        assert(map['Blood Sugar'] != null),
        assert(map['Heart Rate'] != null),
        date = map['Date'],
        bloodPressure = map['Blood Pressure'],
        bloodSugar = map['Blood Sugar'],
        heartRate = map['Heart Rate'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$date:$bloodPressure:$bloodSugar:$heartRate>";
}

class _HealthRecordState extends State<HealthRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Health Entries'),
        centerTitle: true,
        leading: BackButton(onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new HomePage()));
        }),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('health_entries').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.date),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: DataTable(
          columns: [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Blood Pressure')),
            DataColumn(label: Text('Blood Sugar')),
            DataColumn(label: Text('Heart Rate')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text(record.date)),
              DataCell(Text(record.bloodPressure.toString())),
              DataCell(Text(record.bloodSugar.toString())),
              DataCell(Text(record.heartRate.toString()))
            ])
          ],
        ),
      ),
    );
  }
}
