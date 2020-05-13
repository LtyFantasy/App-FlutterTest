
import 'package:flutter/widgets.dart';
import 'package:my_flutter/model.dart';
import 'package:my_flutter/route_path.dart';

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
      
      GridModel(name: "ListTest", event: (BuildContext context, Object argument) {
        Navigator.of(context).pushNamed(
            RoutePath.ListTest, arguments: argument);
      }),
      GridModel(name: "ChallengeSwiperTest", event: (BuildContext context, Object argument) {
        Navigator.of(context).pushNamed(RoutePath.ContainerTest);
      }),
      GridModel(name: "SectionListTest", event: (BuildContext context, Object argument) {
        Navigator.of(context).pushNamed(RoutePath.SectionList);
      }),
      GridModel(name: "NetworkImage", event: (BuildContext context, Object argument) {
        Navigator.of(context).pushNamed(RoutePath.NetworkImageTest);
      }),
      GridModel(name: "StructTest", event: (BuildContext context, Object argument) {
        Navigator.of(context).pushNamed(RoutePath.StructTest);
      }),
      
      GridModel(name: "InOutAnimation", event: (BuildContext context, Object argument){
        Navigator.of(context).pushNamed(RoutePath.InOutAnimation);
      }),
      
      GridModel(name: "第七块"),
      GridModel(name: "第八块"),
      GridModel(name: "第九块"),
      GridModel(name: "第十块"),
    ];
  }
}