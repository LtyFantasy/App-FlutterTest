import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AnimationTestState> buildEffect() {
  return combineEffects(<Object, Effect<AnimationTestState>>{
    AnimationTestAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AnimationTestState> ctx) {
}
