import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(NetworkImageTestState state, Dispatch dispatch, ViewService viewService) {
  
  List<String> urls = [
    "http://aliyun-oss-image.img-us-west-1.aliyuncs.com/2020/01/06/5e1309897748ab28618b4567",
    "http://aliyun-oss-image.img-us-west-1.aliyuncs.com/2018/10/10/5bbd69a67748ab66208b4833"
  ];
  
  return Scaffold(
    appBar: AppBar(
      title: Text("NetworkImageTest"),
      backgroundColor: state.themeColor,
    ),
    body: ListView.builder(
        itemCount: urls.length,
        itemBuilder: (BuildContext context, int index) {
          //return createNetworkImage(urls[index]);
          return createAdvanceNetworkImage(urls[index]);
        }
    ),
  );
}

Widget createAdvanceNetworkImage(String url) {
  
  return TransitionToImage(
    key: ValueKey(url),
    height: 50,
    width: 100,
    color: Colors.blue,
    image: AdvancedNetworkImage(
      url,
      useDiskCache: true,
      cacheRule: CacheRule(maxAge: Duration(seconds: 20)),
      loadFailedCallback: () {
        print("加载失败 $url");
      }
    ),
    loadingWidget: Container(
      height: 40,
      width: 40,
      color: Colors.green,
    ),
    placeholder: Container(
      height: 40,
      width: 40,
      color: Colors.red,
    ),
  );
}

Widget createNetworkImage(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (BuildContext context, String url) {
      return Container(
        color: Colors.green,
      );
    },
    errorWidget: (BuildContext context, String url, Object error) {
      return Container(
        color: Colors.red,
      );
    },
  );
}
