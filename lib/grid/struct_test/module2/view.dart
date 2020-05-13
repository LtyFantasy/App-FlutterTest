import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(StructModule2State state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text("StructModule2"),
      backgroundColor: Colors.blue,
    ),
    body: Container(
      child: Center(
        child: Text(
            "Module2"
        ),
      ),
    ),
  );
}
