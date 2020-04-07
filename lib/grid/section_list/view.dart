import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/section_list/widgets/section_list.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SectionListState state, Dispatch dispatch, ViewService viewService) {
  
  return Scaffold(
    appBar: AppBar(
      title: Text("SectionList"),
    ),
    body: SectionList(
      dataSource: _DataSource(),
    )
  );
}

class _DataSource implements SectionListDataSource {
  
  @override
  int numberOfSection() {
    return 3;
  }
  
  @override
  int numberOfCellInSection(int section) {
    return 20;
  }
  
  @override
  double heightForSectionHeader(int section) {
    return 50;
  }
  
  @override
  Widget widgetForSectionHeader(int section) {
    return Container(
			color: Colors.red,
      child: Center(
        child: Text("Header $section"),
      ),
    );
  }
  
  @override
  double heightForCell(int section, int row) {
    return 40;
  }
  
  @override
  Widget widgetForCell(int section, int row) {
    
    return Container(
      child: Center(
        child: Text("section $section, cell $row"),
      ),
    );
  }
}


