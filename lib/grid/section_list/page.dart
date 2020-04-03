import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SectionListPage extends Page<SectionListState, Map<String, dynamic>> {
  SectionListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SectionListState>(
                adapter: null,
                slots: <String, Dependent<SectionListState>>{
                }),
            middleware: <Middleware<SectionListState>>[
            ],);

}
