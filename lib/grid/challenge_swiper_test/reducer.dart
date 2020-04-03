import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ContainerTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<ContainerTestState>>{
      ContainerTestAction.action: _onAction,
    },
  );
}

ContainerTestState _onAction(ContainerTestState state, Action action) {
  final ContainerTestState newState = state.clone();
  return newState;
}
