import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ListTestItemState state, Dispatch dispatch, ViewService viewService) {
  return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      height: 120,
      color: Colors.white,
      child: GestureDetector(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                              typeString(state.type)
                          )
                      ),
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  Container(
                                      height: 30,
                                      child: Text(
                                          state.title,
                                          style: TextStyle(fontSize: 22),
                                      ),
                                  ),
                                  Text(
                                      state.content,
                                      style: TextStyle(fontSize: 16),
                                  )
                              ],
                          ),
                      ),
                  )
              ],
          ),
          onTap: () {
              print("Cell Tapped");
          },
      ),
  );
}

String typeString (int type) {
    return type == 0 ? "Zero" : "Other";
}