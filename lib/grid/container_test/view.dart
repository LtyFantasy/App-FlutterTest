import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ContainerTestState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white12,
    appBar: AppBar(
      title: Text("ContainerTestPage"),
    ),
    body: Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Text(
              "Responde to his selfie challenge and talk to him for free"
          ),
          RaisedButton(
            child: Center(
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
