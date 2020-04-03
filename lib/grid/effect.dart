import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'package:my_flutter/common_widget/arrow_message_alert.dart';
import 'package:my_flutter/route_path.dart';
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
  
  int index = action.payload["index"];
  Offset offset = action.payload["offset"];

  if (index == 1) {

    Navigator.of(ctx.context).pushNamed(
        RoutePath.ListTest, arguments: {"index": index});
  }
  else if (index == 2) {

    Navigator.of(ctx.context).pushNamed(RoutePath.ContainerTest);
  }
  else if (index == 3) {
    
    Navigator.of(ctx.context).pushNamed(RoutePath.SectionList);
  }
  else {

      ArrowMessageAlert.show(
          context:ctx.context,
          text:"Respond to his selfie challenge and talk to him for free",
          startPoint: offset,
          callback: (){
            print("点击了Ok");
      });
  }
}