import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchAnimationState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchAnimationState>>{
      SearchAnimationAction.action: _onAction,
    },
  );
}

SearchAnimationState _onAction(SearchAnimationState state, Action action) {
  final SearchAnimationState newState = state.clone();
  return newState;
}
