import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/struct_test/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StructModule2Component extends Component<StructModule2State> {
  StructModule2Component()
      : super(
            wrapper: keepAliveClientWrapper,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<StructModule2State>(
                adapter: null,
                slots: <String, Dependent<StructModule2State>>{
                }),);

}

class StructModule2Connector extends ConnOp<StructTestState, StructModule2State> {
  
  @override
  void set(StructTestState state, StructModule2State subState) {
    state.module2Value = subState.value;
  }
  
  @override
  StructModule2State get(StructTestState state) {
    return StructModule2State()
      ..value = state.module2Value;
  }
}
