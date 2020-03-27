import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ListTestItemState> buildEffect() {
  return combineEffects(<Object, Effect<ListTestItemState>>{
    ListTestItemAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ListTestItemState> ctx) {
}
