import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(StructModule1State state, Dispatch dispatch, ViewService viewService) {
  
  return Scaffold(
    appBar: AppBar(
      title: Text("StructModule1"),
      backgroundColor: Colors.blue,
    ),
    body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.value
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                dispatch(StructModule1ActionCreator.onAddValue(state.value + "1"));
              },
              child: Text("AddButton"),
            )
          ],
        )
      ),
    ),
  );
}
