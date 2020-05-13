import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StructTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<StructTestState>>{
      StructTestAction.action: _onAction,
    },
  );
}

StructTestState _onAction(StructTestState state, Action action) {
  final StructTestState newState = state.clone();
  return newState;
}


