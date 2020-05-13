import 'package:flutter/material.dart';
import '../constants/User_Colors.dart';

Widget TopRow(context, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.drag_handle,
              color: Color(User_Colors().purple),
            ),
          ),
        ),
        Text("$title", style: Theme.of(context).textTheme.headline),
      ],
    ),
  );
}
