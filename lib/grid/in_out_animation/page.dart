import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class InOutAnimationPage extends Page<InOutAnimationState, Map<String, dynamic>> {
  InOutAnimationPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<InOutAnimationState>(
                adapter: null,
                slots: <String, Dependent<InOutAnimationState>>{
                }),
            middleware: <Middleware<InOutAnimationState>>[
            ],);

}
