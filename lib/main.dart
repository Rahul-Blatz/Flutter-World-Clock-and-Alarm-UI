import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'constants/User_Colors.dart';

void main() => runApp(MyHomepage());

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(
              fontSize: 56.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Varela',
              color: Color(User_Colors().purple)),
          headline: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Varela',
              color: Color(User_Colors().purple)),
        ),
      ),
      title: 'Clock Design',
      home: Homepage(title: 'Clock Design'),
    );
  }
}
