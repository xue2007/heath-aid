import 'package:flutter/material.dart';
import 'package:testing/auth_provider.dart';
import 'login_page.dart';
import 'auth.dart';
import 'root_page.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Health-Aid',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: RootPage(),
      ),
    );
  }
}