//This is the UI for customized Analog clock for showing time.

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:four_in_one_clock/constants/User_Colors.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

class Clocks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClockState();
  }
}

class ClockState extends State<Clocks> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Container(
            width: 270,
            height: 270,
            decoration: BoxDecoration(
//              color: Colors.yellow,
              color: Color(User_Colors().darkSilver),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(4.0, 4.0),
                    blurRadius: 5.0,
                    spreadRadius: 0.5),
                BoxShadow(
                    color: Color(User_Colors().darkSilver),
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
//              color: Colors.green,
              color: Color(User_Colors().silver),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(4.0, 4.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Color(User_Colors().silver),
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Color(User_Colors().silver),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(4.0, 4.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Color(User_Colors().silver),
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ],
            ),
          ),
        ),
        Center(
          child: CustomPaint(
            painter: ShapesPainter(),
          ),
        ),
        Center(
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(User_Colors().red),
            ),
          ),
        ),
      ],
    );
  }
}

//The Custom seconds,hours and minutes sticks of the Clock
class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    //Seconds Line

    var angle = Vector.radians(90);
    canvas.rotate(angle);
    final paint = Paint()..strokeCap = StrokeCap.round;
    var center = Offset((size.width / 2), (size.height / 2));

    final secondsP1 = center;
//    print(DateTime.now().second);
    double secondsDegree = 360 / 60 * DateTime.now().second;
    double x = (size.width / 1) +
        (size.width / 1 - 110) * cos(Vector.radians(secondsDegree));
    double y = (size.width / 1) +
        (size.width / 1 - 110) * sin(Vector.radians(secondsDegree));

    final secondsP2 = Offset(x, y);
    paint.color = Color(User_Colors().red);
    paint.strokeWidth = 4;
    canvas.drawLine(secondsP1, secondsP2, paint);

    final minutesP1 = center;
    double minutesDegree = 360 / 60 * DateTime.now().minute;
    x = (size.width / 1) +
        (size.width / 1 - 80) * cos(Vector.radians(minutesDegree));
    y = (size.width / 1) +
        (size.width / 1 - 80) * sin(Vector.radians(minutesDegree));

    final minutesP2 = Offset(x, y);
    paint.color = Color(User_Colors().purple);
    paint.strokeWidth = 4;
    canvas.drawLine(minutesP1, minutesP2, paint);

    final hoursP1 = center;
    double hoursDegree = 360 / 12 * (DateTime.now().hour - 12);
    x = (size.width / 2) +
        (size.width / 3 - 50) * cos(Vector.radians(hoursDegree));
    y = (size.width / 2) +
        (size.width / 3 - 50) * sin(Vector.radians(hoursDegree));

    final hoursP2 = Offset(x, y);
    paint.color = Color(User_Colors().yellow);
    paint.strokeWidth = 4;
    canvas.drawLine(hoursP1, hoursP2, paint);

    //External Lines

    for (int i = 0; i < 60; i++) {
      //line position
      double minute = 360 / 60 * i;

      //style every 5 minute
      paint.color = (i % 15 == 0) ? Colors.grey : Colors.white;
      paint.strokeWidth = (i % 15 == 0) ? 4 : 1;

//      int distance = (i%15==0)?10:15;

      double x1 = (size.width / 2) +
          (size.width / 3 + 118) * cos(Vector.radians(minute));
      double y1 = (size.height / 2) +
          (size.width / 3 + 118) * sin(Vector.radians(minute));

      final p1 = Offset(x1, y1);

      double x2 = (size.width / 2) +
          (size.width / 3 + 123) * cos(Vector.radians(minute));
      double y2 = (size.height / 2) +
          (size.width / 3 + 123) * sin(Vector.radians(minute));

      final p2 = Offset(x2, y2);

      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
