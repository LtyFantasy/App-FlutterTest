import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_main_animation_widget.dart';

class SearchAnimationState implements Cloneable<SearchAnimationState> {
  
  GlobalKey<SearchMainAnimationWidgetState> searchViewKey;
  SearchMainAnimationWidgetState get searchView => searchViewKey.currentState;

  @override
  SearchAnimationState clone() {
    return SearchAnimationState()
      ..searchViewKey = searchViewKey;
  }
}

SearchAnimationState initState(Map<String, dynamic> args) {
  return SearchAnimationState()
    ..searchViewKey = GlobalKey<SearchMainAnimationWidgetState>();
}
