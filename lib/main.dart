import 'package:birthday/screen/birthday-list.dart';
import 'package:birthday/screen/login.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  if (kIsWeb) {
    FacebookAuth.i.webInitialize(
      appId: "973488023479794",//<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }

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
      home: BirthdayListScreen(),
    );
  }
}
