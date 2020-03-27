import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/list_test/item/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListTestState>>{
      ListTestAction.action: _onAction,
      ListTestAction.setupListData: _onSetupListData,
    },
  );
}

ListTestState _onAction(ListTestState state, Action action) {
  final ListTestState newState = state.clone();
  return newState;
}

ListTestState _onSetupListData(ListTestState state, Action action) {
  final List<ListTestItemState> data = action.payload ?? <ListTestItemState>[];
  final ListTestState newState = state.clone();
  newState.itemDatas = data;
  return newState;
}
