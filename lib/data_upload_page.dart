import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthForm extends StatefulWidget {
  @override
  _HealthFormState createState() => _HealthFormState();
}

class _HealthFormState extends State<HealthForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Health Upload Form')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Please fill in at least one of the health metrics',
                    style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  hintText: 'What is the date today?',
                  labelText: 'Date *',
                ),
              )
            ]),
      ),
    );
  }
}
