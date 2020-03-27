import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListTestItemState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListTestItemState>>{
      ListTestItemAction.action: _onAction,
    },
  );
}

ListTestItemState _onAction(ListTestItemState state, Action action) {
  final ListTestItemState newState = state.clone();
  return newState;
}
