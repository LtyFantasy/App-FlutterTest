import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SectionListState> buildEffect() {
  return combineEffects(<Object, Effect<SectionListState>>{
    SectionListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SectionListState> ctx) {
}
