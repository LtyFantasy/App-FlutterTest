import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/ListTest/Item/state.dart';
import 'package:my_flutter/store/state.dart';

class ListTestState implements GlobalBaseState, Cloneable<ListTestState> {

  int index;
  List<ListTestItemState> itemDatas;
  
  @override
  Color themeColor;

  @override
  ListTestState clone() {
      return ListTestState()
          ..index = index
          ..itemDatas = itemDatas
          ..themeColor = themeColor;
  }
}

ListTestState initState(Map<String, dynamic> args) {
  return ListTestState()
          ..index = args["index"];
}
