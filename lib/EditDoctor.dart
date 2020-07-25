import 'package:flutter/material.dart';
import 'database.dart';
import 'auth_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'helper.dart';

class EditDoctor extends StatefulWidget {


  @override
  _EditDoctorState createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  DataBase databaseMethods = new DataBase();
  TextEditingController nameController = new TextEditingController();
  TextEditingController specialisationController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();
  TextEditingController expertiseController = new TextEditingController();


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
            SizedBox(height: 20,),
            _buildSpecialisationField(),
            _buildAboutField(),
            _buildExpertiseField(),
            RaisedButton(
              child:Text('Update Profile'),
              onPressed: (){
                createProfile();
                displayAlert();
              },
            ),
          ],

        ),

      ),
      );

  }
  createProfile() {
    String id =''+Constants.myName;
      Map<String, dynamic> profileMap = {
        'name':nameController.text,
        'specialisation':specialisationController.text,
        'about':aboutController.text,
        'expertise':expertiseController.text,
      };
      databaseMethods.createDoctorProfile('abc', profileMap);

  }


  Widget _buildSpecialisationField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Specialisation'),
      controller: specialisationController,
      validator: (String value){
        if(value.isEmpty){
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value){
        specialisationController.text = value;
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
  Widget _buildAboutField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'About'),
      controller: aboutController,
      validator: (String value){
        if(value.isEmpty){
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value){
        aboutController.text = value;
      },

    );
  }
  Widget _buildExpertiseField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Expertise'),
      controller: expertiseController,
      validator: (String value){
        if(value.isEmpty){
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String value){
        expertiseController.text = value;
      },

    );
  }
  Widget displayAlert() {
    String _error = 'submitted';
    if (_error != null) {
      return Container(
        color: Colors.orange,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(Icons.error_outline),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text('uploaded'),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _error = null;
                });
              },
            )
          ],
        ),
      );
    }
    return null;
  }


}
