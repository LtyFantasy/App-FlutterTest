
import 'dart:ui';

import 'package:flutter/cupertino.dart';

/// 屏幕布局方法
///
/// 确保在不同宽度手机上，UI效果与设计图一致
double dp(dynamic value) {

  if (value is int || value is double) {
    return UIScreen.factor * value;
  }
  else {
    return 0;
  }
}

class UIScreen {
  
  /// UI的设计图宽度
  static const double UIScreenWidth = 375.0;
  
  static MediaQueryData mediaQueryData = MediaQueryData.fromWindow(window);
  static double screenWidth = mediaQueryData.size.width;
  
  /// 进行布局的屏宽比系数
  static double factor = screenWidth / UIScreenWidth;
}