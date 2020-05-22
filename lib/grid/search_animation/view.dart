import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_animation_photo.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_grid_animation_list.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_info_widget.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_main_animation_widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SearchAnimationState state, Dispatch dispatch, ViewService viewService) {
  
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF3F146B),
          Color(0xFF4D1854)
        ],
        begin:Alignment.topCenter,
        end: Alignment.bottomCenter
      )
    ),
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
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                top: 60,
                child: SearchMainAnimationWidget(
                  key: state.searchViewKey,
                  animationDone: () {
                    state.gridPhoto.startAnimation();
                  },
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: SearchGridAnimationList(
                        key: state.gridPhotoKey,
                        animationCompleteCallback: () {
                          /// 顶部Grid头像动画完毕后，就执行下面的详情动画
                          state.searchInfo.startAnimation();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 20),
                      child: SearchInfoWidget(
                        key: state.searchInfoKey,
                        peoples: 382,
                        originPrice: 14.99,
                        discountPrice: 9.99,
                        onTap: () {
          
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    ),
  );
}
