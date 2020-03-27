import 'package:fish_redux/fish_redux.dart';

class ContainerTestState implements Cloneable<ContainerTestState> {

  @override
  ContainerTestState clone() {
    return ContainerTestState();
  }
}

ContainerTestState initState(Map<String, dynamic> args) {
  return ContainerTestState();
}
