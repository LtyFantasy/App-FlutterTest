import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchAnimationState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchAnimationState>>{
      SearchAnimationAction.showLocationBlur: _onShowLocationBlur
    },
  );
}

/// 设置是否显示背景高斯模糊
SearchAnimationState _onShowLocationBlur(SearchAnimationState state, Action action) {
  final SearchAnimationState newState = state.clone();
  newState.showLocationBlur = action.payload;
  return newState;
}
