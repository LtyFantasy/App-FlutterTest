import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AnimationTestPage extends Page<AnimationTestState, Map<String, dynamic>> {
  AnimationTestPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AnimationTestState>(
                adapter: null,
                slots: <String, Dependent<AnimationTestState>>{
                }),
            middleware: <Middleware<AnimationTestState>>[
            ],);

}
