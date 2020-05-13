import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NetworkImageTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<NetworkImageTestState>>{
      NetworkImageTestAction.action: _onAction,
    },
  );
}

NetworkImageTestState _onAction(NetworkImageTestState state, Action action) {
  final NetworkImageTestState newState = state.clone();
  return newState;
}
