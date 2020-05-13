import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AnimationTestAction { action }

class AnimationTestActionCreator {
  static Action onAction() {
    return const Action(AnimationTestAction.action);
  }
}
