import 'package:flutter/material.dart';
import 'package:testing/database.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'helper.dart';
import 'database.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;



  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}
  enum FormType {
  login,
    register
  }

  class _LoginPageState extends State<LoginPage> {
  DataBase databaseMethods = new DataBase();
  final ky = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _role;
  String _name;
  FormType _formType = FormType.login;


  bool validateAndSave() {
    final form = ky.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
      return false;

  }

  void validateAndSubmit() async {
  if(validateAndSave()) {
    try {
      if(_formType == FormType.login) {
        String userId = await widget.auth.signInWithEmailAndPassWord(_email, _password);
        QuerySnapshot userInfoSnapshot =
        await databaseMethods.getUserInfo(_email);

        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserNameSharedPreference(
            userInfoSnapshot.documents[0].data["name"]);
        HelperFunctions.saveUserEmailSharedPreference(
            userInfoSnapshot.documents[0].data["email"]);
        print('Signed in: ${userId}');


      } else {
        String user = await widget.auth.createUserWithEmailAndPassWord(_email, _password);
        Firestore.instance.collection('users').document(user).setData({'email': _email,'uid': user,'role': _role, 'name':_name});
        Map<String,String> userDataMap = {
          "name" : _name,
          "email" : _email
        };

        databaseMethods.addUserInfo(userDataMap);

        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserNameSharedPreference(_name);
        HelperFunctions.saveUserEmailSharedPreference(_email);
        print('Registered user: ${user}');

      }
      widget.onSignedIn();
    } catch(e){
        print('Error: $e');
    }
  }
  }
  void moveToRegister() {
    ky.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    ky.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
  bool _checkedValue = false;
  bool _checkedValue1 = false;
  void _doSomething1(bool item) => setState(() => _checkedValue1 = item);
  void _doSomething(bool isChecked) {
    setState((){
      _checkedValue = isChecked;
    });
  }
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('HealthAid Login Page'),
      ),
      body: new Container(
        padding: EdgeInsets.all(15.0),
        child: new Form(
          key: ky,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: inputs() + submitButtons(),
          ),
        )
      )
    );
  }

  List<Widget> inputs() {

      if(_formType == FormType.login) {
        return [
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Email'),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (x) => x.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (x) => _password = x,
        ),
    ];
      } else {
        return [
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Email'),
            validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) => _email = value,
          ),
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (x) => x.isEmpty ? 'Password can\'t be empty' : null,
            onSaved: (x) => _password = x,
          ),
        new TextFormField(
          decoration: new InputDecoration(labelText:'Name'),
          obscureText: true,
          validator: (x) => x.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (x) => _name = x,
        ),
    ];
      }

  }

  List<Widget> submitButtons() {
    if(_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20)),
          onPressed: validateAndSubmit,
        ),
        new RaisedButton(
          child: new Text(
              'Create an account', style: new TextStyle(fontSize: 20)),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
            new Text('choose your roles:'),
            new CheckboxListTile(
              title: new Text('doctor'),
              value: _checkedValue,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged:(newValue) {
                _doSomething(newValue);
                if(newValue){
                  _role = 'doctor';
                }
                },
            ),
        new CheckboxListTile(
          title: new Text('patient'),
          value: _checkedValue1,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged:(newValue) {
            _doSomething1(newValue);
            if(newValue) {
              _role = 'patient';
            }
          },
        ),

        new RaisedButton(
          child: new Text('Create an Account', style: new TextStyle(fontSize: 20)),
          onPressed: validateAndSubmit,
        ),
        new RaisedButton(
          child: new Text(
              'Have an Account?', style: new TextStyle(fontSize: 20)),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}