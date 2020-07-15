import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/auth_constants.dart';
import 'package:testing/doctor_homepage.dart';
import 'LoginPageDoctor.dart';
import 'auth.dart';
import 'auth_provider.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStates {
  firstPagePatient,
  signedInPatient,
  signedInDoctor,
  notDetermined,
  firstPageDoctor
}

class _RootPageState extends State<RootPage> {
  AuthStates authStatus = AuthStates.notDetermined;

  void _signedInPatient() {
    setState(() {
      authStatus = AuthStates.signedInPatient;
    });
  }

  void _signedInDoctor() {
    setState(() {
      authStatus = AuthStates.signedInDoctor;
    });
  }

  void _signedOutPatient() {
    setState(() {
      authStatus = AuthStates.firstPagePatient;
    });
  }

  void _signedOutDoctor() {
    setState(() {
      authStatus = AuthStates.firstPageDoctor;
    });
  }

  /*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      auth.currentUser().then((id) {
        print("AuthStatus is now ${authStatus.toString()}");
        setState(() {
          //authStatus = id == null ? AuthStates.firstPage : AuthStates.signedIn;

            if (Constants.checkRole == true) {
              authStatus = AuthStates.signedInDoctor;
            } else {
              authStatus = AuthStates.signedIn;
              print('$id');
            }

        });
      });
    } catch (e) {}
  }
*/

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStates.firstPagePatient:
        return new LoginPage(
          //auth: widget.auth,
          onSignedIn: _signedInPatient,
          backToMain: () {
            setState(() {
              authStatus = AuthStates.notDetermined;
            });
          },
        );
      case AuthStates.signedInPatient:
        return new HomePage(
          //auth: widget.auth,
          onSignedOut: _signedOutPatient,
        );
      case AuthStates.signedInDoctor:
        return new AllUsersPage(
          //auth: widget.auth,
          onSignedOut: _signedOutDoctor,
        );
      case AuthStates.firstPageDoctor:
        return new LoginPageDoctor(
          onSignedIn: _signedInDoctor,
          backToMain: () {
            setState(() {
              authStatus = AuthStates.notDetermined;
            });
          },
        );
      case AuthStates.notDetermined:
        return _buildWaitingScreen();
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                'Welcome To HealthAid',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 60,
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Image.asset("assets/doctor.jpg"),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    authStatus = AuthStates.firstPageDoctor;
                  });
                  print('doctor');
                },
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
                  padding: const EdgeInsets.only(
                      left: 103, right: 103, top: 10, bottom: 10),
                  child: const Text('Doctor', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 100,
                child: ClipOval(
                  child: Image.asset(
                    "assets/patient.jpg",
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    authStatus = AuthStates.firstPagePatient;
                  });
                  print('patient');
                },
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
                  padding: const EdgeInsets.only(
                      left: 103, right: 103, top: 10, bottom: 10),
                  child: const Text('Patient', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                height: 0.13,
              ),
              SizedBox(
                height: 5,
              )
            ],
          )),
    );
  }
}
