import 'package:flutter/material.dart';
import 'PatientDetails.dart';
import 'patients_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/dataRepository.dart';
import 'package:testing/home_page.dart';
import 'package:testing/patient_profile.dart';
import 'package:testing/root_page.dart';
//import 'package:testing/datahandling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'datahandling.dart';
import 'dataRepository.dart';
import 'patients.dart';
import 'entry_model.dart';
import 'PatientDetails.dart';

const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

class RecordPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Patient Health Entries',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeList());
  }
}

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return _buildList(context, snapshot.data.documents);
          }), // TODO Add StreamBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPatient();
        },
        tooltip: 'Add Patient',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addPatient() {
    AlertDialogWidget dialogWidget = AlertDialogWidget();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Add Patient"),
              content: dialogWidget,
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      Patient newPatient = Patient(dialogWidget.patientName,
                          type: dialogWidget.character);
                      repository.addPatient(newPatient);
                      // TODO Add New Patient to repository
                      Navigator.of(context).pop();
                    },
                    child: Text("Add")),
              ]);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    // TODO Add Snapshot list
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot
          .map((data) => _buildListItem(context, data))
          .toList(), // TODO Add _BuildListItem call with snapshot list
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    // TODO Add Snapshot list
    // TODO Get Patient from snapshot
    final patient = Patient.fromSnapshot(snapshot);
    if (patient == null) {
      return Container();
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(patient.name == null ? "" : patient.name,
                      style: BoldStyle)), // TODO add patient name
              _getPatientIcon(patient.type) // TODO Add pet type
            ],
          ),
          onTap: () {
            _navigate(BuildContext context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PatientDetails(patient), // TODO add patient
                  ));
            }

            _navigate(context);
          },
          highlightColor: Colors.green,
          splashColor: Colors.blue,
        ));
  }

  Widget _getPatientIcon(String type) {
    Widget patientIcon;
    if (type == "diabetic") {
      patientIcon = IconButton(
        icon: Icon(Patients.diabetic),
        onPressed: () {},
      );
    } else if (type == "hi_bp") {
      patientIcon = IconButton(
        icon: Icon(Patients.hi_bp),
        onPressed: () {},
      );
    } else {
      patientIcon = IconButton(
        icon: Icon(Icons.accessibility),
        onPressed: () {},
      );
    }
    return patientIcon;
  }
}

class AlertDialogWidget extends StatefulWidget {
  String patientName;
  String character = '';

  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter a Patient Name"),
            onChanged: (text) => widget.patientName = text,
          ),
          RadioListTile(
            title: Text("Diabetic"),
            value: "diabetic",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
          RadioListTile(
            title: Text("Hi-BP"),
            value: "hi-BP",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() {
                widget.character = value;
              });
            },
          ),
          RadioListTile(
            title: Text("Other"),
            value: "other",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() {
                widget.character = value;
              });
            },
          )
        ],
      ),
    );
  }
}
