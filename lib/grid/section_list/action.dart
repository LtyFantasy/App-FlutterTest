import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SectionListAction { action }

class SectionListActionCreator {
  static Action onAction() {
    return const Action(SectionListAction.action);
  }
}
