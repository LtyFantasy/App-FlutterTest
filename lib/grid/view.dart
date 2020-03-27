import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GridState state, Dispatch dispatch, ViewService viewService) {
  
  return Scaffold(
    appBar: AppBar(
      title: Text("GridPage"),
      backgroundColor: state.themeColor,
    ),
    body: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1/1,
      padding: EdgeInsets.all(20),
      children: List.generate(state.models.length, (index) {
        return Center(
          child: Card(
            color: Colors.lightBlueAccent,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(100),
              onTap: (){
                  dispatch(GridActionCreator.onGridTapped(index + 1));
              },
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(state.models[index].name),
                ),
              ),
            ),
          ),
        );
      }),
    )
  );
}
