import 'package:fish_redux/fish_redux.dart';

class AnimationTestState implements Cloneable<AnimationTestState> {

  @override
  AnimationTestState clone() {
    return AnimationTestState();
  }
}

AnimationTestState initState(Map<String, dynamic> args) {
  return AnimationTestState();
}
