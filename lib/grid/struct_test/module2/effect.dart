import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<StructModule2State> buildEffect() {
  return combineEffects(<Object, Effect<StructModule2State>>{
    StructModule2Action.action: _onAction,
  });
}

void _onAction(Action action, Context<StructModule2State> ctx) {
}
