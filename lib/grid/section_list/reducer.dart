import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SectionListState> buildReducer() {
  return asReducer(
    <Object, Reducer<SectionListState>>{
      SectionListAction.action: _onAction,
    },
  );
}

SectionListState _onAction(SectionListState state, Action action) {
  final SectionListState newState = state.clone();
  return newState;
}
