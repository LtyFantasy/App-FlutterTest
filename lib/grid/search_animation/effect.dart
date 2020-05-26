import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchAnimationState> buildEffect() {
  return combineEffects(<Object, Effect<SearchAnimationState>>{
    Lifecycle.initState: _onInit
  });
}

void _onInit(Action action, Context<SearchAnimationState> ctx) async {

}
