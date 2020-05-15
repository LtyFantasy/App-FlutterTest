import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:my_flutter/entrance/page.dart';
import 'package:my_flutter/grid/challenge_swiper_test/page.dart';
import 'package:my_flutter/grid/in_out_animation/page.dart';
import 'package:my_flutter/grid/list_test/page.dart';
import 'package:my_flutter/grid/network_image/page.dart';
import 'package:my_flutter/grid/page.dart';
import 'package:my_flutter/grid/search_animation/page.dart';
import 'package:my_flutter/grid/section_list/page.dart';
import 'package:my_flutter/grid/struct_test/page.dart';
import 'package:my_flutter/route_path.dart';
import 'package:my_flutter/store/state.dart';
import 'package:my_flutter/store/store.dart';

Widget createApp() {

  final AbstractRoutes routes = PageRoutes(
    
      pages: <String, Page<Object, dynamic>>{
        RoutePath.Entrance: EntrancePage(),
        RoutePath.Grid: GridPage(),
        RoutePath.ListTest: ListTestPage(),
        RoutePath.ContainerTest: ContainerTestPage(),
        RoutePath.SectionList: SectionListPage(),
        RoutePath.NetworkImageTest: NetworkImageTestPage(),
        RoutePath.StructTest: StructTestPage(),
        RoutePath.InOutAnimation: InOutAnimationPage(),
        RoutePath.SearchAnimation: SearchAnimationPage(),
      },
      
      visitor: (String path, Page<Object, dynamic> page) {
          if (page.isTypeof<GlobalBaseState>()) {
              page.connectExtraStore<GlobalState>(GlobalStore.store, (Object pageState, GlobalState appState) {
                  final GlobalBaseState s = pageState;
                  if (s.themeColor != appState.themeColor && pageState is Cloneable) {
                      Object copy = pageState.clone();
                      final GlobalBaseState newState = copy;
                      newState.themeColor = appState.themeColor;
                      return newState;
                  }
                  return pageState;
              });
          }
      }
  );

  return MaterialApp(
    title: "FlutterTest",
    home: routes.buildPage(RoutePath.Entrance, null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (BuildContext context){
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}