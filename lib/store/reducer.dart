
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:my_flutter/store/action.dart';
import 'package:my_flutter/store/state.dart';

Reducer<GlobalState> buildReducer() {
    return asReducer(
      <Object, Reducer<GlobalState>> {
            GlobalAction.changeThemeColor: _onChangeThemeColor,
        }
    );
}

GlobalState _onChangeThemeColor (GlobalState state, Action action) {
    
    final Color color = action.payload ?? Colors.blue;
    return state.clone()
            ..themeColor = color;
}