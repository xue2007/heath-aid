import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
import 'patients.dart';
import 'entry_model.dart';
import 'dataRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_profile.dart';

typedef DialogCallback = void Function();

class PatientDetails extends StatelessWidget {
  final Patient patient;
  const PatientDetails(this.patient);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(patient.name == null
              ? ""
              : patient.name), // TODO add patient name
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: PatientDetailForm(patient), // TODO add patient
      ),
    );
  }
}

class PatientDetailForm extends StatefulWidget {
  final Patient patient;
  const PatientDetailForm(this.patient);

  @override
  _PatientDetailFormState createState() => _PatientDetailFormState();
}

class _PatientDetailFormState extends State<PatientDetailForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final dateFormat = DateFormat('yyyy-MM-dd');
  String name;
  String type;
  String notes;

  @override
  void initState() {
    type = widget.patient.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: FormBuilder(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            FormBuilderTextField(
              attribute: "name",
              initialValue: widget.patient.name,
              // TODO use patient name
              decoration: textInputDecoration.copyWith(
                  hintText: 'Name', labelText: "Patient Name"),
              validators: [
                FormBuilderValidators.minLength(1),
                FormBuilderValidators.required()
              ],
              onChanged: (val) {
                setState(() => name = val);
              },
            ),
            FormBuilderRadio(
              decoration: InputDecoration(labelText: 'Patient Type'),
              attribute: "Diabetic",
              initialValue: type,
              leadingInput: true,
              options: [
                FormBuilderFieldOption(
                    value: "Diabetic",
                    child: Text(
                      "Diabetic",
                      style: TextStyle(fontSize: 16.0),
                    )),
                FormBuilderFieldOption(
                    value: "Hi-BP",
                    child: Text(
                      "Hi-BP",
                      style: TextStyle(fontSize: 16.0),
                    )),
                FormBuilderFieldOption(
                    value: "other",
                    child: Text(
                      "Other",
                      style: TextStyle(fontSize: 16.0),
                    )),
              ],
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            FormBuilderTextField(
              attribute: "notes",
              initialValue: widget.patient.notes, // TODO Add patient notes
              decoration: textInputDecoration.copyWith(
                  hintText: 'Notes', labelText: "Notes"),
              onChanged: (val) {
                setState(() {
                  notes = val;
                });
              },
            ),
            FormBuilderCustomField(
              attribute: "health-entries",
              formField: FormField(
                enabled: true,
                builder: (FormFieldState<dynamic> field) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 6.0),
                      Text(
                        "Health Entries",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(16.0),
                          itemCount: widget.patient.entries == null
                              ? 0
                              : widget.patient.entries
                                  .length, // TODO use entries count
                          itemBuilder: (BuildContext context, int index) {
                            return buildRow(widget.patient
                                .entries[index]); // TODO Pass in entries
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                _addEntry(widget.patient, () {
                  // TODO add Patient
                  setState(() {});
                });
              },
              tooltip: 'Add Entry',
              child: Icon(Icons.add),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    )),
                MaterialButton(
                    color: Colors.blue.shade600,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop();
                        widget.patient.name = name;
                        widget.patient.type = type;
                        widget.patient.notes = notes;
                        repository.updatePatient(widget.patient);
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(Entry entry) {
    // TODO Add Entry class
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(entry.entry), // TODO Add Entry name
        ),
        Text(entry.date == null
            ? ""
            : dateFormat.format(entry.date)), // TODO Add Date
        Checkbox(
          value: entry.verified == null
              ? false
              : entry.verified, // TODO add verified
          onChanged: (newValue) {
            entry.verified = newValue;
          },
        )
      ],
    );
  }

  void _addEntry(Patient patient, DialogCallback callback) {
    // TODO Add Patient
    String entry;
    DateTime entryDate;
    bool done = false;
    final _formKey = GlobalKey<FormBuilderState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Entry"),
              content: SingleChildScrollView(
                child: FormBuilder(
                  key: _formKey,
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        attribute: "entry",
                        validators: [
                          FormBuilderValidators.minLength(1),
                          FormBuilderValidators.required()
                        ],
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter a Entry Name', labelText: "Entry"),
                        onChanged: (text) {
                          setState(() {
                            entry = text;
                          });
                        },
                      ),
                      FormBuilderDateTimePicker(
                        attribute: "date",
                        inputType: InputType.date,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter a Entry Date', labelText: "Date"),
                        onChanged: (text) {
                          setState(() {
                            entryDate = text;
                          });
                        },
                      ),
                      FormBuilderCheckbox(
                        attribute: "verified",
                        label: Text("Verified"),
                        onChanged: (text) {
                          setState(() {
                            done = text;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop();
                        Entry newEntry =
                            Entry(entry, date: entryDate, verified: verified);
                        if (patient.entries == null) {
                          patient.entries = List<Entry>();
                        }
                        patient.entries.add(newEntry);
                      }
                      callback();
                    },
                    child: Text("Add")),
              ]);
        });
  }
}
