import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<NetworkImageTestState> buildEffect() {
  return combineEffects(<Object, Effect<NetworkImageTestState>>{
    NetworkImageTestAction.action: _onAction,
  });
}

void _onAction(Action action, Context<NetworkImageTestState> ctx) {
}
