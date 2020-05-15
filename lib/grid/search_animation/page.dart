import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchAnimationPage extends Page<SearchAnimationState, Map<String, dynamic>> {
  SearchAnimationPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchAnimationState>(
                adapter: null,
                slots: <String, Dependent<SearchAnimationState>>{
                }),
            middleware: <Middleware<SearchAnimationState>>[
            ],);

}
