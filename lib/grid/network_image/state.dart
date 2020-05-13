import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/store/state.dart';

class NetworkImageTestState extends GlobalBaseState implements Cloneable<NetworkImageTestState> {
  
  @override
  Color themeColor;
  
  @override
  NetworkImageTestState clone() {
    return NetworkImageTestState()
      ..themeColor = themeColor;
  }
}

NetworkImageTestState initState(Map<String, dynamic> args) {
  return NetworkImageTestState();
}
