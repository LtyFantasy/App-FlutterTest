import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GridState> buildEffect() {
  return combineEffects(<Object, Effect<GridState>>{
    Lifecycle.initState: _onInit,
    GridAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GridState> ctx) {

}

void _onInit(Action action, Context<GridState> ctx) {
  ctx.dispatch(GridActionCreator.onLoadData());
}
