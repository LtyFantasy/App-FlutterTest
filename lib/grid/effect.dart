import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:my_flutter/route_path.dart';
import 'package:my_flutter/store/action.dart';
import 'package:my_flutter/store/store.dart';
import 'action.dart';
import 'state.dart';

Effect<GridState> buildEffect() {
  return combineEffects(<Object, Effect<GridState>>{
    Lifecycle.initState: _onInit,
    GridAction.action: _onAction,
    GridAction.gridTapped: _onGridTapped,
  });
}

void _onAction(Action action, Context<GridState> ctx) {

}

void _onInit(Action action, Context<GridState> ctx) {
  ctx.dispatch(GridActionCreator.onLoadData());
}

void _onGridTapped(Action action, Context<GridState> ctx) {

  if (action.payload == 1) {

    Navigator.of(ctx.context).pushNamed(
        RoutePath.ListTest, arguments: {"index": action.payload});
  }
  else if (action.payload == 2) {
    GlobalStore.store.dispatch(GlobalActionCreator.onChangeThemeColor(Colors.red));
  }
  else {
    GlobalStore.store.dispatch(GlobalActionCreator.onChangeThemeColor(Colors.green));
  }
}