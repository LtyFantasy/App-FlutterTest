import 'package:fish_redux/fish_redux.dart';

class ListTestItemState implements Cloneable<ListTestItemState> {

  int type;
  String title;
  String content;

  ListTestItemState({this.type, this.title, this.content});

  @override
  ListTestItemState clone() {
    return ListTestItemState()
      ..type = type
      ..title = title
      ..content = content;
  }
}

ListTestItemState initState(Map<String, dynamic> args) {
  return ListTestItemState();
}
