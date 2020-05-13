import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/struct_test/state.dart';

class StructModule1State implements Cloneable<StructModule1State> {
  
  String value;

  @override
  StructModule1State clone() {
    return StructModule1State()
      ..value = value;
  }
}

StructModule1State initState(Map<String, dynamic> args) {
  return StructModule1State();
}