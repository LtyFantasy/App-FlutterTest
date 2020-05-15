import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_animation_photo.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_grid_animation_list.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_main_animation_widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SearchAnimationState state, Dispatch dispatch, ViewService viewService) {
  
  return Container(
    color: Colors.blue,
    child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          title: Text(""),
          elevation: 0,
          leading: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              FocusScope.of(viewService.context).requestFocus(FocusNode());
              Navigator.pop(viewService.context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(viewService.context).iconTheme.color,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.build),
              onPressed: () {
                state.searchView.startAnimation();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            //child: SearchMainAnimationWidget(key: state.searchViewKey),
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  child: SearchGridAnimationList(),
                )
              ],
            ),
          ),
        ),
    ),
  );
}
