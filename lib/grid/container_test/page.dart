import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ContainerTestPage extends Page<ContainerTestState, Map<String, dynamic>> {
  ContainerTestPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ContainerTestState>(
                adapter: null,
                slots: <String, Dependent<ContainerTestState>>{
                }),
            middleware: <Middleware<ContainerTestState>>[
            ],);

}
