import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ListTestItemComponent extends Component<ListTestItemState> {
  ListTestItemComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ListTestItemState>(
                adapter: null,
                slots: <String, Dependent<ListTestItemState>>{
                }),);

}
