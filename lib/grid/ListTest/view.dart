import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/ListTest/adapter.dart';

import 'state.dart';

Widget buildView(ListTestState state, Dispatch dispatch, ViewService viewService) {

  ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      title: Text("ListTestPage"),
      backgroundColor: state.themeColor,
    ),
    body: Container(
      child: ListView.builder(
          itemBuilder: adapter.itemBuilder,
          itemCount: adapter.itemCount,
      )
    ),
  );
}
