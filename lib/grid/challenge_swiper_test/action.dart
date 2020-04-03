import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ContainerTestAction { action }

class ContainerTestActionCreator {
  static Action onAction() {
    return const Action(ContainerTestAction.action);
  }
}
