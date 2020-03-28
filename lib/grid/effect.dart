import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:my_flutter/common_widget/arrow_message_alert.dart';
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

    Navigator.of(ctx.context).pushNamed(RoutePath.ContainerTest);
  }
  else {

    ArrowMessageAlert.show(ctx.context, "这是你关注的好友，他已经恢复你了，赶快去联系吧，这样就能愉快的交流了。", callback: (){
      print("点击了Ok");
    });
  }
}