import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class StructTestState implements Cloneable<StructTestState> {
  
  int currentIndex;
  PageController pageController;
  
  String module1Value;
  String module2Value;

  @override
  StructTestState clone() {
    return StructTestState()
      ..currentIndex = currentIndex
      ..pageController = pageController
      ..module1Value = module1Value
      ..module2Value = module2Value;
  }
}

StructTestState initState(Map<String, dynamic> args) {
  return StructTestState()
    ..currentIndex = 0
    ..pageController = PageController(
      initialPage: 0,
      keepPage: true
    )
    ..module1Value = "module1"
    ..module2Value = "module2";
}
