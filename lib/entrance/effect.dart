import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:my_flutter/route_path.dart';
import 'action.dart';
import 'state.dart';

Effect<EntranceState> buildEffect() {
  return combineEffects(<Object, Effect<EntranceState>>{
    EntranceAction.action: _onAction,
    EntranceAction.openGrid: _onOpenGrid
  });
}

void _onAction(Action action, Context<EntranceState> ctx) {
}

void _onOpenGrid(Action action, Context<EntranceState> ctx) {
 Navigator.of(ctx.context).pushNamed(RoutePath.Grid, arguments: null);
}
