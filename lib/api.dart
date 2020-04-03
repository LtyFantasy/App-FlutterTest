
import 'package:my_flutter/model.dart';

class Api {

  static Api instance;

  factory Api() {
    return _get();
  }

  static _get() {
    if (instance == null) {
      instance = Api._internal();
    }
    return instance;
  }

  Api._internal();

  List<GridModel> getGridData() {
    return [
      GridModel(name: "ListTest"),
      GridModel(name: "ChallengeSwiperTest"),
      GridModel(name: "SectionListTest"),
      GridModel(name: "第四块"),
      GridModel(name: "第五块"),
      GridModel(name: "第六块"),
      GridModel(name: "第七块"),
      GridModel(name: "第八块"),
      GridModel(name: "第九块"),
      GridModel(name: "第十块"),
    ];
  }
}