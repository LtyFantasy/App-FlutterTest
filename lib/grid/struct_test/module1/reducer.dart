import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StructModule1State> buildReducer() {
  return asReducer(
    <Object, Reducer<StructModule1State>>{
      StructModule1Action.action: _onAction,
      StructModule1Action.addValue: _onAddValue,
    },
  );
}

StructModule1State _onAction(StructModule1State state, Action action) {
  final StructModule1State newState = state.clone();
  return newState;
}

StructModule1State _onAddValue(StructModule1State state, Action action) {
  final StructModule1State newState = state.clone();
  newState.value = action.payload;
  return newState;
}
