import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_animation_photo.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_grid_animation_list.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_info_widget.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_main_animation_widget.dart';
import 'package:my_flutter/tools/ui_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SearchAnimationState state, Dispatch dispatch, ViewService viewService) {
  
  List<Widget> rootWidgets = [
    Container(
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
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: _createStackChildren(state, dispatch),
          ),
        ),
      ),
    )
  ];

  /// 覆盖一层背景，高斯模糊+权限请求文案
  if (state.showLocationBlur == true) {
    rootWidgets.add(_createPermissionRequestBG(viewService.context));
  }
  
  return Stack(children: rootWidgets);
}

List<Widget> _createStackChildren(SearchAnimationState state, Dispatch dispatch) {
  
  return [
    /// 搜索头像雷达图
    Positioned(
      top: dp(60),
      child: SearchMainAnimationWidget(
        key: state.searchViewKey,
        hasAskLocationPermission: true,
        animationSuspended: () async {
          
          // TODO Loki
          /// 获取定位权限期间，展现高斯模糊
          dispatch(SearchAnimationActionCreator.onShowLocationBlur(true));
          PermissionStatus status = await Permission.locationWhenInUse.request();
          dispatch(SearchAnimationActionCreator.onShowLocationBlur(false));
          /// 继续动画
          state.searchView.resumeAnimation();
        },
        animationDone: () {
          /// 启动下一阶段动画，滚动头像列表
          state.gridPhoto.startAnimation();
        },
      ),
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: dp(200),
          child: SearchGridAnimationList(
            key: state.gridPhotoKey,
            animationCompleteCallback: () {
              /// 顶部Grid头像动画完毕后，就执行下面的详情动画
              state.searchInfo.startAnimation();
            },
          ),
        ),
        Expanded(
          child: SearchInfoWidget(
            key: state.searchInfoKey,
            peoples: 382,
            originPrice: 14.99,
            discountPrice: 9.99,
            onTap: () {
              // TODO Loki 点击事件
            },
          ),
        )
      ],
    )
    /*
    /// 滚动头像列表 + 价格文案与按钮
    SingleChildScrollView(
      child: ,
    )*/
  ];
}

Widget _createPermissionRequestBG(BuildContext context) {
  
  final MediaQueryData queryData =  MediaQueryData.fromWindow(window);
  final EdgeInsets padding = queryData.padding;
  double topOffset = (queryData.size.height - padding.top - padding.bottom) / 2;
  if (padding.bottom > 0) {
    topOffset += dp(10);
  }
  
  // TODO Loki iOS 11和以下版本，仅仅显示高斯模糊，不带任何引导文案
  return BackdropFilter(
    filter: new ImageFilter.blur(sigmaX: 6, sigmaY: 6),
    child: new Container(
      color: Colors.black38.withOpacity(0.2),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            _createPermissionLeftArrow(topOffset),
            _createPermissionRightArrow(topOffset),
            _createPermissionWording(),
          ],
        ),
      ),
    ),
  );
}

Widget _createPermissionLeftArrow(double topOffset) {
  
  return Positioned(
    left: dp(15),
    top: topOffset,
    child: Icon(
      Icons.arrow_forward_ios,
      color: Colors.white,
    ),
  );
}

Widget _createPermissionRightArrow(double topOffset) {
  
  return Positioned(
    right: dp(15),
    top: topOffset,
    child: Icon(
      Icons.arrow_back_ios,
      color: Colors.white,
    ),
  );
}

/// 获取权限时，底部的引导文案
Widget _createPermissionWording() {
  
  TextStyle style = TextStyle(
      fontSize: dp(16),
      color: Colors.white
  );
  
  return Container(
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.only(bottom: dp(120)),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          children: [
            TextSpan(
                text: "Click \"",
                style: style
            ),
            TextSpan(
              // TODO Loki 根据iOS版本，切换文案
                text: "Allow White Using App",
                style: style.apply(color: Colors.blue)
            ),
            TextSpan(
                text: "\"\nRecommend interesting people ❤️ nearby",
                style: style
            )
          ]
      ),
    ),
  );
}