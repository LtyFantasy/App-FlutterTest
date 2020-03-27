import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

// 全局页面state都应该继承
abstract class GlobalBaseState {

    Color get themeColor;
    set themeColor(Color color);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {

    @override
    Color themeColor;
    
    @override
    GlobalState clone() {
        return GlobalState();
    }
}