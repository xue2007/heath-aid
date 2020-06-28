import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing/Constants.dart';
import 'package:testing/database.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_provider.dart';
import'helper.dart';
import 'database.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn,this.backToMain});

  final BaseAuth auth;
  final VoidCallback onSignedIn;
  final VoidCallback backToMain;



  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}
  enum FormType {
  login,
    register,
  }

  class _LoginPageState extends State<LoginPage> {
  DataBase databaseMethods = new DataBase();
  final ky = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _role;
  String _name;
  FormType _formType = FormType.login;


  void checkDoctor() {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          print('checked');
          if (docs.documents[0].data['role'] == 'doctor') {
            Constants.checkRole = true;
            print('doctor is true');
          } else {
            Constants.checkRole = false;
            print('doctor is false');
          }
        }
      });
    });
  }

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
      final BaseAuth auth = AuthProvider.of(context).auth;
      if(_formType == FormType.login) {

        String userId = await auth.signInWithEmailAndPassWord(_email, _password);
        checkDoctor();
        QuerySnapshot userInfoSnapshot =
        await databaseMethods.getUserInfo(_email);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserNameSharedPreference(
            userInfoSnapshot.documents[0].data["name"]);
        HelperFunctions.saveUserEmailSharedPreference(
            userInfoSnapshot.documents[0].data["email"]);
        HelperFunctions.saveUserRoleSharedPreference(
            userInfoSnapshot.documents[0].data["role"]);
        print('Signed in: ${userId}');

      } else {
       /* Map<String,String> userDataMap = {
          "name" : _name,
          "email" : _email,
          "role":_role
        };
        databaseMethods.addUserInfo(userDataMap);*/
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserNameSharedPreference(_name);
        HelperFunctions.saveUserEmailSharedPreference(_email);
        String user = await auth.createUserWithEmailAndPassWord(_email, _password);
        Firestore.instance.collection('users').document(user).setData({'email': _email,'uid': user,'role': _role, 'name':_name});
        checkDoctor();
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
        leading:BackButton(
            onPressed: () {
              widget.backToMain();
            }
      ),
        title: new Text('HealthAid Patient Login Page'),
      ),
      body: new Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cool1.jpg'),
            fit: BoxFit.cover
          )
        ),
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
       Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 15),
            RaisedButton(
              onPressed: validateAndSubmit,
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.only(left:160,right:160,top: 8,bottom: 8),
                child:
                const Text('Login', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 5),
            RaisedButton(
              onPressed: moveToRegister,
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF9C27B0),
                      Color(0xFFE040FB),
                      Color(0xFF9C27B0),
                    ],
                  ),
                ),
                padding: const EdgeInsets.only(left:103,right:103,top: 10,bottom: 10),
                child:
                const Text('Create an Account', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
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