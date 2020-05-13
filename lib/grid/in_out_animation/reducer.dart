import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<InOutAnimationState> buildReducer() {
  return asReducer(
    <Object, Reducer<InOutAnimationState>>{
      InOutAnimationAction.action: _onAction,
    },
  );
}

InOutAnimationState _onAction(InOutAnimationState state, Action action) {
  final InOutAnimationState newState = state.clone();
  return newState;
}
