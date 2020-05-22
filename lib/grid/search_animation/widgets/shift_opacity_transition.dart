
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShiftOpacityTransition extends AnimatedWidget {
  
  /// 动画时间值监听
  Animation<double> get animationFactor => listenable as Animation<double>;
  
  /// 被做动画的控件
  final Widget child;
  
  /// 边距插值器
  final EdgeInsets Function(double animationValue) insetsMaker;
  
  const ShiftOpacityTransition({
    Key key,
    @required Animation<double> animation,
    @required this.insetsMaker,
    this.child
  }) : assert(animation != null),
        super(key: key, listenable: animation);
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: insetsMaker(animationFactor.value),
      child: Opacity(
        opacity: animationFactor.value,
        child: child,
      ),
    );
  }
}

