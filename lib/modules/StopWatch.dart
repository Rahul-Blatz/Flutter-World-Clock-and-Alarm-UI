import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:four_in_one_clock/constants/constantNumbers.dart';
import 'fancy_button.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'clock_face.dart';
import 'clock_dialog.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;
import 'dart:math';
import '../constants/User_Colors.dart';

enum ButtonState { Start, Stop, Reset }

class StopWatches extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatches> {
  String timeToDisplay = '00:00:00', lap = '00:00:00', prevLap = '00:00:00';
  ButtonState button;
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);
  double sec, min;

  @override
  void initState() {
    sec = 0;
    min = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1),
        (Timer t) => TimerHands(seconds: sec, minutes: min));
    Timer(dur, keepRunning);
  }

  void keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      min = (swatch.elapsed.inMinutes % 60).toDouble();
      sec = (swatch.elapsed.inSeconds % 60).toDouble();
      timeToDisplay = swatch.elapsed.inHours.toString().padLeft(2, '0') +
          ':' +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          ':' +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');
    });
  }

  void startStopWatch() {
    swatch.start();
    startTimer();
  }

  void stopStopWatch() {
    swatch.stop();
    lap = lapTime().substring(0, 7);
    prevLap = timeToDisplay;
  }

  String lapTime() {
    Duration laps = parseDuration(prevLap, timeToDisplay);
    return laps.toString();
  }

  Duration parseDuration(String s, String t) {
    int phours = 0;
    int pminutes = 0;
    int pseconds = 0;
    List<String> pTime = s.split(':');
    List<String> cTime = t.split(':');
    if (pTime.length > 2) {
      phours = int.parse(cTime[cTime.length - 3]) -
          int.parse(pTime[pTime.length - 3]);
    }
    if (pTime.length > 1) {
      pminutes = int.parse(cTime[cTime.length - 2]) -
          int.parse(pTime[pTime.length - 2]);
    }
    pseconds =
        int.parse(cTime[cTime.length - 1]) - int.parse(pTime[pTime.length - 1]);

    return Duration(hours: phours, minutes: pminutes, seconds: pseconds);
  }

  void resetStopWatch() {
    swatch.stop();
    swatch.reset();
    sec = 0;
    min = 0;
    timeToDisplay = '00:00:00';
    lap = '00:00:00';
    prevLap = '00:00:00';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: ClockFace(
                height: 270.0,
                width: 270.0,
              ),
            ),
            Center(
              child: Container(
                child: CustomPaint(
                  size: Size(250, 250),
                  painter: ClockDialog(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78.0),
              child: Center(
                child: Text(
                  '$timeToDisplay',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Varela',
                  ),
                ),
              ),
            ),
            Center(
              child: CustomPaint(
                painter: TimerHands(seconds: sec, minutes: min),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: FancyButton(
                label: 'Start',
                onPress: () {
                  setState(() {
                    button = ButtonState.Start;
                    startStopWatch();
                  });
                },
                gradient: button == ButtonState.Start
                    ? kActiveButtonGradient
                    : kInActiveButtonGradient,
              ),
            ),
            Container(
              child: FancyButton(
                label: 'Stop',
                onPress: () {
                  setState(() {
                    button = ButtonState.Stop;
                    stopStopWatch();
                  });
                },
                gradient: button == ButtonState.Stop
                    ? kActiveButtonGradient
                    : kInActiveButtonGradient,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.0,
        ),
        Container(
          child: FancyButton(
            label: 'Reset',
            onPress: () {
              setState(() {
                button = ButtonState.Reset;
                resetStopWatch();
              });
            },
            gradient: button == ButtonState.Reset
                ? kActiveButtonGradient
                : kInActiveButtonGradient,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.white, width: 2.0),
          ),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
              gradient: kInActiveButtonGradient,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Container(
              width: 200.0,
              height: 60.0,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Lap : ',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                      color: Color(User_Colors().purple),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    lap,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                      color: Color(User_Colors().purple),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class TimerHands extends CustomPainter {
  TimerHands({this.seconds, this.minutes});
  double seconds;
  double minutes;
  @override
  void paint(Canvas canvas, Size size) {
//    print(seconds);
    var angle = Vector.radians(90);
    canvas.rotate(angle);
    final paint = Paint()..strokeCap = StrokeCap.round;
    var center = Offset((size.width / 2), (size.height / 2));

    final secondsP1 = center;
    double secondsDegree = 360 / 60 * seconds;
    double x = (size.width / 1) +
        (size.width / 1 - 110) * cos(Vector.radians(secondsDegree));
    double y = (size.width / 1) +
        (size.width / 1 - 110) * sin(Vector.radians(secondsDegree));
    final secondsP2 = Offset(x, y);
    paint.color = Color(User_Colors().red);
    paint.strokeWidth = 4;
    canvas.drawLine(secondsP1, secondsP2, paint);

    final minutesP1 = center;
    double minutesDegree = 360 / 60 * minutes;
    x = (size.width / 1) +
        (size.width / 1 - 80) * cos(Vector.radians(minutesDegree));
    y = (size.width / 1) +
        (size.width / 1 - 80) * sin(Vector.radians(minutesDegree));

    final minutesP2 = Offset(x, y);
    paint.color = Color(User_Colors().brightYellow);
    paint.strokeWidth = 4;
    canvas.drawLine(minutesP1, minutesP2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
