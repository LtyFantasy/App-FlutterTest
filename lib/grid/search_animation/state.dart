import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_grid_animation_list.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_info_widget.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_main_animation_widget.dart';

class SearchAnimationState implements Cloneable<SearchAnimationState> {
  
  /// 搜索雷达图动画
  GlobalKey<SearchMainAnimationWidgetState> searchViewKey;
  SearchMainAnimationWidgetState get searchView => searchViewKey.currentState;
  
  /// 顶部滚动头像Grid列表
  GlobalKey<SearchGridAnimationListState> gridPhotoKey;
  SearchGridAnimationListState get gridPhoto => gridPhotoKey.currentState;
  
  /// 下面的价格文案+按钮
  GlobalKey<SearchInfoWidgetState> searchInfoKey;
  SearchInfoWidgetState get searchInfo => searchInfoKey.currentState;
  
  /// 是否显示获取定位权限时的高斯模糊背景
  bool showLocationBlur;

  @override
  SearchAnimationState clone() {
    return SearchAnimationState()
      ..searchViewKey = searchViewKey
      ..gridPhotoKey = gridPhotoKey
      ..searchInfoKey = searchInfoKey
      ..showLocationBlur = showLocationBlur;
  }
}

SearchAnimationState initState(Map<String, dynamic> args) {
  return SearchAnimationState()
    ..searchViewKey = GlobalKey<SearchMainAnimationWidgetState>()
    ..gridPhotoKey = GlobalKey<SearchGridAnimationListState>()
    ..searchInfoKey = GlobalKey<SearchInfoWidgetState>()
    ..showLocationBlur = false;
}
