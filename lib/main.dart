import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth.dart';
import 'root_page.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(context) {
    return new MaterialApp(
      title: 'Health-Aid',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RootPage(auth: new Auth())
    );
  }
}