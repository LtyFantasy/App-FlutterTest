import 'package:fish_redux/fish_redux.dart';

enum SearchAnimationAction {
  showLocationBlur,
}

class SearchAnimationActionCreator {
  
  /// 设置是否显示定位权限获取时，背景的高斯模糊
  static Action onShowLocationBlur(bool show) {
    return Action(SearchAnimationAction.showLocationBlur, payload: show);
  }
}
