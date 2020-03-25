import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ListTestState> buildEffect() {
  return combineEffects(<Object, Effect<ListTestState>>{
    ListTestAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ListTestState> ctx) {
}
