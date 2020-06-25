import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final ky = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _role;
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
        print('Signed in: ${userId}');

      } else {
        String user = await widget.auth.createUserWithEmailAndPassWord(_email, _password);
        Firestore.instance.collection('users').document(user).setData({'email': _email,'uid': user,'role': _role});
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
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText:'Password'),
        obscureText: true,
        validator: (x) => x.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (x) => _password = x,
      ),

    ];
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