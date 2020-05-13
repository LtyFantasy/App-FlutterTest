import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<StructModule1State> buildEffect() {
  return combineEffects(<Object, Effect<StructModule1State>>{
    StructModule1Action.action: _onAction,
  });
}

void _onAction(Action action, Context<StructModule1State> ctx) {
}
