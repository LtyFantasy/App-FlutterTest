import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/ListTest/Item/state.dart';

//TODO replace with your own action
enum ListTestAction {
  action,
  setupListData,
}

class ListTestActionCreator {
  
  static Action onAction() {
      return const Action(ListTestAction.action);
  }
  
  static Action onSetupListData(List<ListTestItemState> itemDatas) {
      return Action(ListTestAction.setupListData, payload: itemDatas);
  }
}
