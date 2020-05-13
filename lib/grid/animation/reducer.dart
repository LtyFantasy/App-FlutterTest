import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AnimationTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<AnimationTestState>>{
      AnimationTestAction.action: _onAction,
    },
  );
}

AnimationTestState _onAction(AnimationTestState state, Action action) {
  final AnimationTestState newState = state.clone();
  return newState;
}
