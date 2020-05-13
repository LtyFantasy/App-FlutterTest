import 'package:fish_redux/fish_redux.dart';

enum StructTestAction {
  action,
}

class StructTestActionCreator {
  
  static Action onAction() {
    return const Action(StructTestAction.action);
  }
  
}

