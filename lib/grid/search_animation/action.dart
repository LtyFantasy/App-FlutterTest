import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchAnimationAction { action }

class SearchAnimationActionCreator {
  static Action onAction() {
    return const Action(SearchAnimationAction.action);
  }
}
