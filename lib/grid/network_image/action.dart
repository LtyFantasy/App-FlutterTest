import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum NetworkImageTestAction { action }

class NetworkImageTestActionCreator {
  static Action onAction() {
    return const Action(NetworkImageTestAction.action);
  }
}
