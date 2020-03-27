import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(EntranceState state, Dispatch dispatch, ViewService viewService) {

  return Scaffold(

    appBar: AppBar(
      title: Text("EntrancePage"),
      backgroundColor: state.themeColor,
    ),
    body: Container(

      child: Center(

        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          color: Colors.green,
          child: Text(
            "点击",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: (){
            dispatch(EntranceActionCreator.onOpenGrid());
          },
        ),
      ),
    ),
  );
}
