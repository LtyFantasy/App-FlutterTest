import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ListTestPage extends Page<ListTestState, Map<String, dynamic>> {
  ListTestPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ListTestState>(
                adapter: null,
                slots: <String, Dependent<ListTestState>>{
                }),
            middleware: <Middleware<ListTestState>>[
            ],);

}
