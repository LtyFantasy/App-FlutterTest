import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StructModule2State> buildReducer() {
  return asReducer(
    <Object, Reducer<StructModule2State>>{
      StructModule2Action.action: _onAction,
    },
  );
}

StructModule2State _onAction(StructModule2State state, Action action) {
  final StructModule2State newState = state.clone();
  return newState;
}

