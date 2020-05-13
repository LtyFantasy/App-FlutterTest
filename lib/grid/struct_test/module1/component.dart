import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/struct_test/state.dart';


import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StructModule1Component extends Component<StructModule1State> {
  StructModule1Component()
      : super(
            wrapper: keepAliveClientWrapper,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<StructModule1State>(
                adapter: null,
                slots: <String, Dependent<StructModule1State>>{
                }),);

}

class StructModule1Connector extends ConnOp<StructTestState, StructModule1State> {
  
  @override
  void set(StructTestState state, StructModule1State subState) {
    state.module1Value = subState.value;
  }
  
  @override
  StructModule1State get(StructTestState state) {
    return StructModule1State()
      ..value = state.module1Value;
  }
}
