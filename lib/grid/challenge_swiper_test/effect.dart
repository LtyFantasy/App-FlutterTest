import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ContainerTestState> buildEffect() {
  return combineEffects(<Object, Effect<ContainerTestState>>{
    ContainerTestAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ContainerTestState> ctx) {
}
