
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShiftOpacityTransition extends AnimatedWidget {
  
  /// 动画时间值监听
  Animation<double> get animationFactor => listenable as Animation<double>;
  
  /// 被做动画的控件
  final Widget child;
  
  /// 边距插值器
  final EdgeInsets Function(double animationValue) insetsMaker;

  /// 曲线
  final Cubic curve;
  
  /// 位置
  final AlignmentGeometry alignment;
  
  const ShiftOpacityTransition({
    Key key,
    @required Animation<double> animation,
    @required this.child,
    @required this.insetsMaker,
    this.curve = Curves.easeInOut,
    this.alignment = Alignment.topLeft,
  }) : assert(animation != null),
        super(key: key, listenable: animation);
  
  @override
  Widget build(BuildContext context) {
    
    double value = curve.transformInternal(animationFactor.value);
    return Container(
      alignment: alignment,
      margin: insetsMaker(value),
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }
}

