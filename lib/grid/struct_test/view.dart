import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/struct_test/page.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(StructTestState state, Dispatch dispatch, ViewService viewService) {
  
  final List<Widget> childPages = [
    viewService.buildComponent(StructModule1),
    viewService.buildComponent(StructModule2),
  ];
  
  return Scaffold(
    backgroundColor: Colors.white,
    body: PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: state.pageController,
      children: childPages,
    ),
    bottomNavigationBar: SafeArea(
      child: Row(
        children: <Widget>[
          createItem(
              text: "Module1",
              onTap: () {
                state.pageController.jumpToPage(0);
              }
          ),
          createItem(
              text: "Module2",
              onTap: () {
                state.pageController.jumpToPage(1);
              }
          )
        ],
      ),
    ),
  );
}

Widget createItem({String text, void Function() onTap}) {
  return Expanded(
    child: Container(
      height: 44,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            alignment: Alignment.center,
            height: 40,
            width: 60,
            child: Text(text),
          ),
        ),
      ),
    ),
  );
}
