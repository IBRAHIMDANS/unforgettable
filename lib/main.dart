import 'package:birthday/screen/login.dart';
import 'package:birthday/screen/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primaryColor: Color.fromRGBO(255, 235, 59, 0),
        primaryColor: Color(0xffffeb3b),
        primaryColorLight: Color.fromRGBO(255, 255, 114, 255),
        primaryColorDark: Color.fromRGBO(200, 185, 0, 255),
      ),
      home: RegisterScreen(),
    );
  }
}
