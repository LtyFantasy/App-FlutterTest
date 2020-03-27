import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/ListTest/Item/state.dart';
import 'action.dart';
import 'state.dart';

Effect<ListTestState> buildEffect() {
  return combineEffects(<Object, Effect<ListTestState>>{
    Lifecycle.initState: _onInit,
    ListTestAction.action: _onAction,
  });
}

void _onInit(Action action, Context<ListTestState> ctx) {

  List<ListTestItemState> mockData = [];
  for (int i = 0; i < 40; i++) {
      mockData.add(ListTestItemState(
          type: i%2,
          title: "$i测试标题",
          content: "$i测试内容文本，测试内容文本，测试内容文本"
      ));
  }
  
  ctx.dispatch(ListTestActionCreator.onSetupListData(mockData));
}

void _onAction(Action action, Context<ListTestState> ctx) {

}
