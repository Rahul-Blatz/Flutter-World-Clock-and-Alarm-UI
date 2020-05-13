import 'dart:math';

import 'package:flutter/material.dart';
import 'package:four_in_one_clock/constants/User_Colors.dart';

class ClockDialog extends CustomPainter {
  final hourTickMarkLength = 10.0;
  final minuteTickMarkLength = 5.0;

  final hourTickMarkWidth = 3.0;
  final minuteTickMarkWidth = 1.5;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  ClockDialog()
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = TextStyle(
            color: Color(User_Colors().purple),
            fontSize: 12.0,
            fontFamily: 'Varela');

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);
    for (var i = 0; i < 60; i++) {
      tickPaint.color = i % 15 == 0 ? Colors.grey : Colors.white;
      tickMarkLength = i & 5 == 0 ? hourTickMarkLength : minuteTickMarkLength;
      tickPaint.strokeWidth =
          i % 5 == 0 ? hourTickMarkWidth : minuteTickMarkWidth;
      canvas.drawLine(Offset(0.0, -radius),
          Offset(0.0, -radius + tickMarkLength), tickPaint);

      if (i % 5 == 0) {
        canvas.save();
        canvas.translate(0.0, -radius + 20.0);

        textPainter.text = TextSpan(
          text: '$i',
          style: textStyle,
        );

        canvas.rotate(-angle * i);

        textPainter.layout();
        textPainter.paint(canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
        canvas.restore();
      }
      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
