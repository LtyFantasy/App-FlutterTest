import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_grid_animation_list.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_info_widget.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_main_animation_widget.dart';

class SearchAnimationState implements Cloneable<SearchAnimationState> {
  
  GlobalKey<SearchMainAnimationWidgetState> searchViewKey;
  SearchMainAnimationWidgetState get searchView => searchViewKey.currentState;
  
  GlobalKey<SearchGridAnimationListState> gridPhotoKey;
  SearchGridAnimationListState get gridPhoto => gridPhotoKey.currentState;
  
  GlobalKey<SearchInfoWidgetState> searchInfoKey;
  SearchInfoWidgetState get searchInfo => searchInfoKey.currentState;

  @override
  SearchAnimationState clone() {
    return SearchAnimationState()
      ..searchViewKey = searchViewKey
      ..gridPhotoKey = gridPhotoKey
      ..searchInfoKey = searchInfoKey;
  }
}

SearchAnimationState initState(Map<String, dynamic> args) {
  return SearchAnimationState()
    ..searchViewKey = GlobalKey<SearchMainAnimationWidgetState>()
    ..gridPhotoKey = GlobalKey<SearchGridAnimationListState>()
    ..searchInfoKey = GlobalKey<SearchInfoWidgetState>();
}
