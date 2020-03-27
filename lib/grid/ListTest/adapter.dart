import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/ListTest/Item/component.dart';
import 'package:my_flutter/grid/ListTest/Item/state.dart';
import 'package:my_flutter/grid/ListTest/state.dart';

class ListTestAdapter extends DynamicFlowAdapter<ListTestState> {
  ListTestAdapter()
      : super(
          pool: <String, Component<Object>>{
              "ListTestItem": ListTestItemComponent()
          },
          connector: _ListTestConnector(),
          );
}

class _ListTestConnector extends ConnOp<ListTestState, List<ItemBean>> {

  @override
  List<ItemBean> get(ListTestState state) {

      if (state.itemDatas?.isNotEmpty == true) {
          // Item数据转换为ItemBean
          return state.itemDatas
              .map<ItemBean>((ListTestItemState state) => ItemBean("ListTestItem", state))
              .toList();
      }
      else {
          return <ItemBean>[];
      }
  }

  @override
  void set(ListTestState state, List<ItemBean> items) {

      if (items?.isNotEmpty == true) {
          state.itemDatas = items.
            map<ListTestItemState>((ItemBean bean) => bean.data).
            toList();
      }
      else {
          state.itemDatas = <ListTestItemState>[];
      }
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
