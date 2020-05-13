import 'package:day_selector/day_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:four_in_one_clock/constants/User_Colors.dart';
import 'package:four_in_one_clock/constants/constantNumbers.dart';
import 'package:four_in_one_clock/modules/TopRow.dart';
import 'dart:math';

///Background am or pm has completed, now add time to select and change the everyday
class AlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlarmPageState();
  }
}

class AlarmPageState extends State<AlarmPage> {
  bool alarmSwitch1 = false;
  bool alarmSwitch2 = false;
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 30);
  TimeOfDay _selectedTime1 = TimeOfDay(hour: 12, minute: 30);
  DateTime now;
  List alarmDay1;
  List alarmDay2;

  String getTimeAlone(TimeOfDay t) {
    String s;
    s = t.toString();
    s = s.substring(10, 15);
    return s;
  }

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
  }

  _selectDay(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return DaySelector(
            value: 0,
            onChange: (value) {
              print(value);
              if (DaySelector.sunday & value == pow(2, now.weekday)) {
                print(now.weekday);
              }
            },
            color: Color(User_Colors().purple),
            mode: DaySelector.modeFull,
          );
        });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              accentColor: Color(User_Colors().brightYellow),
              primaryColor: Color(User_Colors().purple),
              canvasColor: Color(User_Colors().purple),
            ),
            child: child,
          );
        });
    setState(() {
      if (picked != null) _selectedTime = picked;
    });
  }

  Future<void> _selectTime1(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime1,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              accentColor: Color(User_Colors().brightYellow),
              primaryColor: Color(User_Colors().purple),
              canvasColor: Color(User_Colors().purple),
            ),
            child: child,
          );
        });
    setState(() {
      if (picked != null) _selectedTime1 = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopRow(context, 'ALARM'),
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              right: 16.0,
            ),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: kBoxDecoration,
                      height: 200,
                      width: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: alarmSwitch1
                                  ? LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: <Color>[
                                        Color(0xffffc03d),
                                        Color(0xffffd03d),
                                        Color(0xffffe03d),
                                      ],
                                    )
                                  : LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: <Color>[
                                        Color(0xffe7eefb),
                                        Color(0xfff2f5fc),
                                      ],
                                    ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(40.0),
                              ),
                            ),
                            width: double.maxFinite,
                            height: double.maxFinite,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 90.0),
                            child: Text(
                              _selectedTime.periodOffset == 0 ? 'AM' : 'PM',
                              style: TextStyle(
                                fontSize: 100.0,
                                color: Color(0x103c1361),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _selectDay(context);
                                  },
                                  child: Text(
                                    'Everyday',
                                    style: kAlarmText,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectTime(context);
                                  });
                                },
                                child: Text(
                                  getTimeAlone(_selectedTime),
                                  style: kAlarmNumber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          alarmSwitch1 = !alarmSwitch1;
                        });
                      },
                      child: Container(
                        alignment: alarmSwitch1
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: CircleAvatar(
                            backgroundColor: alarmSwitch1
                                ? Color(User_Colors().brightYellow)
                                : Color(User_Colors().purple),
                            radius: 35.0,
                            child: Center(
                              child: Text(
                                alarmSwitch1 ? 'ON' : 'OFF',
                                style: TextStyle(
                                  color: alarmSwitch1
                                      ? Color(User_Colors().purple)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Varela',
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        decoration: kBoxDecoration,
                        height: 120,
                        width: 80,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: kBoxDecoration,
                      height: 200,
                      width: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: alarmSwitch2
                                  ? LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: <Color>[
                                        Color(0xffffc03d),
                                        Color(0xffffd03d),
                                        Color(0xffffe03d),
                                      ],
                                    )
                                  : LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: <Color>[
                                        Color(0xffe7eefb),
                                        Color(0xfff2f5fc),
                                      ],
                                    ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(40.0),
                              ),
                            ),
                            width: double.maxFinite,
                            height: double.maxFinite,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 90.0),
                            child: Text(
                              _selectedTime1.periodOffset == 0 ? 'AM' : 'PM',
                              style: TextStyle(
                                fontSize: 100.0,
                                color: Color(0x103c1361),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _selectDay(context);
                                  },
                                  child: Text(
                                    'Mo Tu Th',
                                    style: kAlarmText,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectTime1(context);
                                  });
                                },
                                child: Text(
                                  getTimeAlone(_selectedTime1),
                                  style: kAlarmNumber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          alarmSwitch2 = !alarmSwitch2;
                        });
                      },
                      child: Container(
                        alignment: alarmSwitch2
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: CircleAvatar(
                            backgroundColor: alarmSwitch2
                                ? Color(User_Colors().brightYellow)
                                : Color(User_Colors().purple),
                            radius: 35.0,
                            child: Center(
                              child: Text(
                                alarmSwitch2 ? 'ON' : 'OFF',
                                style: TextStyle(
                                  color: alarmSwitch2
                                      ? Color(User_Colors().purple)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Varela',
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        decoration: kBoxDecoration,
                        height: 120,
                        width: 80,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
