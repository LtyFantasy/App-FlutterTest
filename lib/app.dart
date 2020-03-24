import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/entrance/page.dart';
import 'package:my_flutter/grid/page.dart';

Widget createApp() {

  final AbstractRoutes routes = PageRoutes(
      pages: <String, Page<Object, dynamic>>{
        "entrance_page": EntrancePage(),
        "grid_page": GridPage()
      },
  );

  return MaterialApp(
    title: "FlutterTest",
    home: routes.buildPage("entrance_page", null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (BuildContext context){
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}