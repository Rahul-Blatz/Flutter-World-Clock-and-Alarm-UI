import 'package:four_in_one_clock/modules/ClockLondon.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../modules/Clocks.dart';
import 'package:intl/intl.dart';
import '../modules/TopRow.dart';
import 'dart:async';

class ClockPage extends StatefulWidget {
  final String title;
  ClockPage({Key key, this.title}) : super(key: key);

  @override
  ClockPageState createState() => ClockPageState();
}

class ClockPageState extends State<ClockPage> {
  DateTime now = DateTime.now();
  String _formattedTime;
  String londonTime;
  bool london = false;
  bool india = true;

  // A Raised button that is customized to show London Time when clicked
  Widget _areaButtonLondon(context, String label) {
    return RaisedButton(
      onPressed: () {
        if (label == 'LONDON') {
          london = !london;
          india = !india;
        }
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.white, width: 2.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: london
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
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Container(
          width: 120.0,
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // A Raised button that is customized to show Indian Time when clicked
  Widget _areaButtonIndia(context, String label) {
    return RaisedButton(
      onPressed: () {
        if (label == 'INDIA') {
          india = !india;
          london = !london;
        }
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.white, width: 2.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: india
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
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Container(
          width: 120.0,
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _formattedTime = DateFormat("kk:mm").format(now);
    Timer.periodic(Duration(seconds: 1),
        (Timer t) => london ? getLondonTime() : _getTime());
    super.initState();
  }

  //Method for getting Indian Time
  void _getTime() {
    final DateTime nows = DateTime.now();
    String formattedDateTime = DateFormat("kk:mm").format(nows);
    if (this.mounted) {
      setState(() {
//        print('India: $formattedDateTime');
        int meridian = int.parse(formattedDateTime.substring(0, 2));
        if (meridian == 24) {
          formattedDateTime = formattedDateTime.replaceRange(0, 2, '00');
          _formattedTime = '$formattedDateTime AM';
        } else if (meridian > 12) {
          meridian = meridian - 12;
          formattedDateTime = formattedDateTime.replaceRange(0, 2, '$meridian');
          _formattedTime = '$formattedDateTime PM';
        } else if (meridian == 12) {
          formattedDateTime = formattedDateTime.replaceRange(0, 2, '$meridian');
          _formattedTime = '$formattedDateTime PM';
        } else {
          _formattedTime = '$formattedDateTime AM';
        }
      });
    }
  }

  //Method for getting London Time(Uses JSON to get London time data from World api) and that's why we use async
  void getLondonTime() async {
    Response response =
        await get("http://worldtimeapi.org/api/timezone/Europe/London");
    Map londonData = jsonDecode(response.body);
    final String londonTimeString = londonData['utc_datetime'];
    londonTime = londonTimeString.substring(11, 16);
    if (this.mounted) {
      setState(() {
//      print('London: londonTime');
        int meridian = int.parse(londonTime.substring(0, 2));
//      print(meridian);
        if (meridian == 24) {
          londonTime = londonTime.replaceRange(0, 2, '00');
          _formattedTime = '$londonTime AM';
        } else if (meridian > 12) {
          meridian = meridian - 12;
          londonTime = londonTime.replaceRange(0, 2, '$meridian');
          _formattedTime = '$londonTime PM';
        } else if (meridian == 12) {
          londonTime = londonTime.replaceRange(0, 2, '$meridian');
          _formattedTime = '$londonTime PM';
        } else {
          _formattedTime = '$londonTime AM';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

//    print("The time is: $now");
    return SafeArea(
      child: ListView(
        children: <Widget>[
          TopRow(context, 'WORLD CLOCK'),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
              child: Container(
                child: Text(
                  "$_formattedTime",
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child: london ? ClockLondon() : Clocks(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(child: _areaButtonLondon(context, 'LONDON')),
                Container(child: _areaButtonIndia(context, "INDIA")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
