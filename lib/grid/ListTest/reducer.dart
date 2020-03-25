import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListTestState>>{
      ListTestAction.action: _onAction,
    },
  );
}

ListTestState _onAction(ListTestState state, Action action) {
  final ListTestState newState = state.clone();
  return newState;
}
