import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum StructModule1Action {
  action,
  addValue,
}

class StructModule1ActionCreator {
  
  static Action onAction() {
    return const Action(StructModule1Action.action);
  }
  
  static Action onAddValue(String value) {
    return Action(StructModule1Action.addValue, payload: value);
  }
}
