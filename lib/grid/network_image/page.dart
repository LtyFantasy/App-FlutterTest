import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NetworkImageTestPage extends Page<NetworkImageTestState, Map<String, dynamic>> {
  NetworkImageTestPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NetworkImageTestState>(
                adapter: null,
                slots: <String, Dependent<NetworkImageTestState>>{
                }),
            middleware: <Middleware<NetworkImageTestState>>[
            ],);

}
