import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SectionListState state, Dispatch dispatch, ViewService viewService) {
  
  return Scaffold(
    appBar: AppBar(
      title: Text("SectionList"),
    ),
    body: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: SectionHeaderDelegate(
            height: 50,
            child: Container(
              color: Colors.red,
              child: Center(
                child: Text("SectionHeader"),
              ),
            )
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 80,
          delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index%2 == 0 ? Colors.blue : Colors.green,
                  child: Center(
                    child: Text("text"),
                  ),
                );
              },
            childCount: 10
          ),
        )
      ],
    ),
  );
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  
  final Widget child;
  final double height;
  
  SectionHeaderDelegate({this.child, this.height});
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
  
  @override
  double get maxExtent => height;
  
  @override
  double get minExtent => height;
  
  @override
  bool shouldRebuild(SectionHeaderDelegate oldDelegate) {
    return oldDelegate.height != height
        && (oldDelegate.child.runtimeType != child.runtimeType
            || oldDelegate.child.key != child.key);
  }
}
