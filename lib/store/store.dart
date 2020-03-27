import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/store/reducer.dart';
import 'package:my_flutter/store/state.dart';

class GlobalStore {
    
    static Store<GlobalState> _store;
    static Store<GlobalState> get store {
        _store ??= createStore<GlobalState>(GlobalState(), buildReducer());
        return _store;
    }
}