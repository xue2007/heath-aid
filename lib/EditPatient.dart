import 'package:flutter/material.dart';
import 'database.dart';
import 'auth_constants.dart';

class EditPatient extends StatefulWidget {

  @override
  _EditPatientState createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {
  DataBase databaseMethods = new DataBase();
  TextEditingController nameController = new TextEditingController();
  TextEditingController bloodPressureController = new TextEditingController();
  TextEditingController heartBeatController = new TextEditingController();
  TextEditingController bloodGlucoseController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController fatController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctors Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            _buildNameField(),
            _buildBloodGlucoseField(),
            _buildBloodPressureField(),
            _buildHeartBeatField(),
            _buildAgeField(),
            _buildFatField(),
            _buildHeightField(),
            _buildWeightField(),

            RaisedButton(
              child:Text('Update Profile'),
              onPressed: (){
                createProfile();
                Navigator.pop(context);
              },
            ),
          ],

        ),

      ),
    );

  }
  @override
  void initState() {
    super.initState();
  }

  createProfile() {
    String id = Constants.myName;
    Map<String, dynamic> profileMap = {

      'users':id,
      'age':ageController.text,
      'name':nameController.text,
      'bloodPressure':bloodPressureController.text,
      'heartBeat':heartBeatController.text,
      'weight':weightController.text,
      'fat':fatController.text,
      'height':heightController.text,
      'bloodGlucose' : bloodGlucoseController.text,

    };
    databaseMethods.createPatientProfile(id, profileMap);
    databaseMethods.createPatientDocuments(id, profileMap);

  }

  Widget _buildBloodPressureField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Blood Pressure'),
      controller: bloodPressureController,
      validator: (String value){
        if(value.isEmpty){
          return 'Blood Pressure is required';
        }
        return null;
      },
      onSaved: (String value){
        bloodPressureController.text = value;
      },
    );
  }
  Widget _buildBloodGlucoseField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Blood Glucose'),
      controller: bloodGlucoseController,
      validator: (String value){
        if(value.isEmpty){
          return 'Blood Glucose is required';
        }
        return null;
      },
      onSaved: (String value){
        bloodGlucoseController.text = value;
      },

    );
  }
  Widget _buildHeartBeatField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'HeartBeat'),
      controller: heartBeatController,
      validator: (String value){
        if(value.isEmpty){
          return 'Heartbeat is required';
        }
        return null;
      },
      onSaved: (String value){
        heartBeatController.text = value;
      },

    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      style: TextStyle(fontSize: 15),
      controller: nameController,
      validator: (String value){
        if(value.isEmpty){
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value){
        nameController.text = value;
      },

    );
  }

  Widget _buildAgeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Age'),
      controller: ageController,
      validator: (String value){
        if(value.isEmpty){
          return 'Age is required';
        }
        return null;
      },
      onSaved: (String value){
        ageController.text = value;
      },

    );
  }
  Widget _buildFatField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Fat percentage'),
      controller: fatController,
      validator: (String value){
        if(value.isEmpty){
          return 'Fat percentage is required';
        }
        return null;
      },
      onSaved: (String value){
        fatController.text = value;
      },

    );
  }
  Widget _buildWeightField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Weight'),
      controller: weightController,
      validator: (String value){
        if(value.isEmpty){
          return 'Weight is required';
        }
        return null;
      },
      onSaved: (String value){
        weightController.text = value;
      },

    );
  }
  Widget _buildHeightField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Height'),
      controller: heightController,
      validator: (String value){
        if(value.isEmpty){
          return 'Height is required';
        }
        return null;
      },
      onSaved: (String value){
        heightController.text = value;
      },

    );
  }

}
