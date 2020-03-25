import 'package:fish_redux/fish_redux.dart';

class ListTestState implements Cloneable<ListTestState> {

  @override
  ListTestState clone() {
    return ListTestState();
  }
}

ListTestState initState(Map<String, dynamic> args) {
  return ListTestState();
}
