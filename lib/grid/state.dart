import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/model.dart';
import 'package:my_flutter/store/state.dart';

class GridState implements GlobalBaseState, Cloneable<GridState> {

  List<GridModel> models;
  
  @override
  Color themeColor;

  @override
  GridState clone() {
    return GridState()
    ..models = models
    ..themeColor = themeColor;
  }
}

GridState initState(Map<String, dynamic> args) {
  return GridState();
}
