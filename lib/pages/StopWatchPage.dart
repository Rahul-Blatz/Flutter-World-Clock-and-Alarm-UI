import 'package:flutter/material.dart';
import 'package:four_in_one_clock/modules/StopWatch.dart';

import '../modules/TopRow.dart';

class StopWatchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StopWatchPageState();
  }
}

class StopWatchPageState extends State<StopWatchPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopRow(context, 'STOP WATCH'),
          StopWatches(),
        ],
      ),
    );
  }
}
