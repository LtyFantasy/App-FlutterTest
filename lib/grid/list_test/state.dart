import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/list_test/item/state.dart';
import 'package:my_flutter/store/state.dart';

class ListTestState implements GlobalBaseState, Cloneable<ListTestState> {
  
  List<ListTestItemState> itemDatas;
  
  @override
  Color themeColor;

  @override
  ListTestState clone() {
      return ListTestState()
          ..itemDatas = itemDatas
          ..themeColor = themeColor;
  }
}

ListTestState initState(Map<String, dynamic> args) {
  return ListTestState();
}
