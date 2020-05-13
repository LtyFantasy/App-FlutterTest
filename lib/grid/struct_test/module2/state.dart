import 'package:fish_redux/fish_redux.dart';

class StructModule2State implements Cloneable<StructModule2State> {
  
  String value;

  @override
  StructModule2State clone() {
    return StructModule2State()
      ..value = value;
  }
}

StructModule2State initState(Map<String, dynamic> args) {
  return StructModule2State();
}
