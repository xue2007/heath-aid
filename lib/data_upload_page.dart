import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class HealthForm extends StatefulWidget {
  @override
  _HealthFormState createState() => _HealthFormState();
}

class _HealthFormState extends State<HealthForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              leading: BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
              title: Text('Health Upload Form')),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Please fill in at least one of the health metrics',
                      style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      hintText: 'What is the date today?',
                      labelText: 'Date *',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.accessibility),
                        hintText: 'What is your blood pressure today?',
                        labelText: 'Blood Pressure / mmHg'),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.accessibility),
                        hintText: 'What is your blood sugar level today?',
                        labelText: 'Blood Sugar / mmol/L'),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.accessibility),
                        hintText: 'What is your heart rate per minute?',
                        labelText: 'Heart Rate / BPM'),
                  ),
                ),
                SizedBox(height: 50),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Upload', style: TextStyle(fontSize: 20)),
                ),
              ])),
    );
  }
}
