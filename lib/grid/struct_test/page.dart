import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/struct_test/module1/component.dart';
import 'package:my_flutter/grid/struct_test/module2/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const String StructModule1 = "StructModule1";
const String StructModule2 = "StructModule2";

class StructTestPage extends Page<StructTestState, Map<String, dynamic>> with SingleTickerProviderMixin<StructTestState> {
  StructTestPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            shouldUpdate: (StructTestState old, StructTestState now) {
              return old != now;
            },
            dependencies: Dependencies<StructTestState>(
                adapter: null,
                slots: <String, Dependent<StructTestState>>{
                  StructModule1: StructModule1Connector() + StructModule1Component(),
                  StructModule2: StructModule2Connector() + StructModule2Component(),
                }),
            middleware: <Middleware<StructTestState>>[
            ],);

}

