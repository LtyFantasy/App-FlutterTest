import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<StructTestState> buildEffect() {
  return combineEffects(<Object, Effect<StructTestState>>{
    StructTestAction.action: _onAction,
  });
}

void _onAction(Action action, Context<StructTestState> ctx) {
}
