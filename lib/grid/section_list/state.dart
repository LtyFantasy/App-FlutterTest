import 'package:fish_redux/fish_redux.dart';

class SectionListState implements Cloneable<SectionListState> {

  @override
  SectionListState clone() {
    return SectionListState();
  }
}

SectionListState initState(Map<String, dynamic> args) {
  return SectionListState();
}
