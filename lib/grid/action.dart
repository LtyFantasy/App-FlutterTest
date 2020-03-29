import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;


enum GridAction {
  action,
  loadData,
  gridTapped
}

class GridActionCreator {

  static Action onAction() {
    return const Action(GridAction.action);
  }

  static Action onLoadData() {
    return const Action(GridAction.loadData);
  }

  static Action onGridTapped(int index, Offset offset) {
    return Action(GridAction.gridTapped, payload: {"index" : index, "offset" : offset});
  }
}
