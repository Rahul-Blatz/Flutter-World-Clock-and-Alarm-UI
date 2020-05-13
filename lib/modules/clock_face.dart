import 'package:flutter/material.dart';
import 'package:four_in_one_clock/constants/User_Colors.dart';

class ClockFace extends StatelessWidget {
  final double width;
  final double height;

  ClockFace({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
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
      child: Center(
        child: Container(
          width: 5.0,
          height: 5.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
