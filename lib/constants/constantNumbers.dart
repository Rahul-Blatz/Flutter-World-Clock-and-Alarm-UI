import 'package:flutter/material.dart';

const int purple = 0xff3c1361;
const int red = 0xffff2525;
const int brightYellow = 0xffffe03d;
const int midYellow = 0xffffd03d;
const int yellow = 0xffffc03d;
const int silver = 0xfff2f5fc;
const int darkSilver = 0xffe7eefb;

const kBoxDecoration = BoxDecoration(
  border: Border(
    right: BorderSide(width: 2, color: Colors.white),
    left: BorderSide(width: 2, color: Colors.white),
    top: BorderSide(width: 2, color: Colors.white),
    bottom: BorderSide(width: 2, color: Colors.white),
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(40.0),
  ),
);

const kAlarmText = TextStyle(
  fontSize: 26.0,
  color: Color(purple),
);

const kAlarmNumber = TextStyle(
  fontSize: 40.0,
  color: Color(purple),
);

const kActiveButtonGradient = LinearGradient(
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  colors: <Color>[
    Color(0xffffc03d),
    Color(0xffffd03d),
    Color(0xffffe03d),
  ],
);

const kInActiveButtonGradient = LinearGradient(
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  colors: <Color>[
    Color(0xffe7eefb),
    Color(0xfff2f5fc),
  ],
);
