import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum InOutAnimationAction { action }

class InOutAnimationActionCreator {
  static Action onAction() {
    return const Action(InOutAnimationAction.action);
  }
}
