import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<InOutAnimationState> buildEffect() {
  return combineEffects(<Object, Effect<InOutAnimationState>>{
    InOutAnimationAction.action: _onAction,
  });
}

void _onAction(Action action, Context<InOutAnimationState> ctx) {
}
