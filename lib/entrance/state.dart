import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/store/state.dart';

class EntranceState implements GlobalBaseState, Cloneable<EntranceState> {
  
  @override
  Color themeColor;

  @override
  EntranceState clone() {
    return EntranceState()
      ..themeColor = themeColor;
  }
}

EntranceState initState(Map<String, dynamic> args) {
  return EntranceState();
}
