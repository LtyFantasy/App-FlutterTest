import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ListTestAction { action }

class ListTestActionCreator {
  static Action onAction() {
    return const Action(ListTestAction.action);
  }
}
