
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 分段ListView控件
///
/// 注意，使用[SectionList]时，一定要实现[SectionListDataSource]这个数据代理
/// 本类的实现思想来自于iOS系统原生的UITableView
///
/// @Author: Loki
/// @CreateDate: 2020/04/06

/// 数据源代理接口
abstract class SectionListDataSource {
	
	/// 有多少个section
	int numberOfSection();
	/// section下有多少个cell
	int numberOfCellInSection(int section);
	
	/// section的header高度，如果为0表示没有header
	double heightForSectionHeader(int section);
	/// section的header控件，前提是高度要先返回>0
	Widget widgetForSectionHeader(int section);
	
	/// section下，row位置的cell高度
	double heightForCell(int section, int row);
	/// section下，row位置的cell控件
	Widget widgetForCell(int section, int row);
}

/// SectionList列表
///
/// 特性：
/// 1，具备分段数据显示
/// 2，分段数据基于dataSource提供，屏蔽了listView本身的itemBuilder逻辑
class SectionList extends StatefulWidget {
	
	final SectionListDataSource dataSource;
	
	SectionList({
		@required this.dataSource
	}) : assert(dataSource != null, "[SectionList] dataSource can't be null");
	
	@override
  State<StatefulWidget> createState() => _SectionListState();
}

class _SectionListState extends State<SectionList> {
	
	// 滚动控制器，用来监听偏移变更事件
	ScrollController scrollController;
	// Section数据
	List<_SectionModel> sectionModel;
	// 所有Item个数
	int totalItemCount;
	
	@override
  void initState() {
    super.initState();
    _dataInit();
		_controllerInit();
  }
	
	@override
  Widget build(BuildContext context) {
    
    return Container(
			padding: EdgeInsets.all(0.0),
			child: Stack(
				children: <Widget>[
					Container(
						color: Colors.transparent,
						child: _createListView(),
					)
				],
			),
		);
  }
  
  // 数据初始化
  void _dataInit() {
		
		sectionModel = [];

		double offsetY = 0;
		int index = 0;
		
		// 获取有多少个section
		int sectionNum = widget.dataSource.numberOfSection();
		for (int section = 0; section < sectionNum; section++) {
			
			double startY = offsetY;
			int startIndex = index;
			
			// 计算Section的Header高度
			double headerHeight = widget.dataSource.heightForSectionHeader(section);
			offsetY += headerHeight;
			// header高度大于0，代表这个section会存在header widget
			if (headerHeight > 0) {
				index++;
			}
			
			// 获取当前section有多少cell
			List<double> cellsHeight = [];
			int cellNum = widget.dataSource.numberOfCellInSection(section);
			index += cellNum;
			for (int row = 0; row < cellNum; row++) {
				
				double cellHeight = widget.dataSource.heightForCell(section, row);
				assert(cellHeight > 0, "[SectionList] cell height must be greater than 0");
				cellsHeight.add(cellHeight);
				offsetY += cellHeight;
			}
			
			sectionModel.add(_SectionModel(
				startY: startY,
				endY: offsetY,
				headerHeight: headerHeight,
				cellsHeight: cellsHeight,
				startIndex: startIndex,
				endIndex: index
			));
		}
		
		totalItemCount = index;
	}
  
  // 控制器初始化
  void _controllerInit() {
		
		scrollController = ScrollController()..addListener((){
			
			double offset = scrollController.offset;
			if (offset <= 0) {
				// TODO update header model
			}
			else {
				// 判断当前offet在哪个section区间
				// TODO 然后设置section header偏移量，update
			}
		});
	}
	
	// 创建主ListView
	Widget _createListView() {
		
		return ListView.builder(
			controller: scrollController,
			physics: AlwaysScrollableScrollPhysics(),
			shrinkWrap: false,
			cacheExtent: 50.0,
			itemCount: totalItemCount,
			itemBuilder: (BuildContext context, int index) {
			
				int section = sectionWithIndex(index);
				assert(section != -1, "[SectionList] section == -1 should not happen,");
				
				// 映射index为所属section的row值
				_SectionModel model = sectionModel[section];
				int row = index - model.startIndex;
				
				Widget itemWidget;
				double itemHeight;
				
				// 判断是否是header item
				if (row == 0 && model.headerHeight > 0) {
					itemHeight = model.headerHeight;
					itemWidget = widget.dataSource.widgetForSectionHeader(section);
				}
				// 是cell
				else {
					
					if (model.headerHeight > 0) {
						row -= 1;
					}
					itemHeight = model.cellsHeight[row];
					itemWidget = widget.dataSource.widgetForCell(section, row);
				}
				
				return ConstrainedBox(
					constraints: BoxConstraints(
						minHeight: itemHeight,
						maxHeight: itemHeight,
					),
					child: itemWidget ?? Container(),
				);
		});
	}
	
	// 转换ListView的Index为所属section
	int sectionWithIndex(int index) {
		
		for (int section = 0; section < sectionModel.length; section++) {
			_SectionModel model = sectionModel[section];
			if (model.itemCount > 0 && index >= model.startIndex && index < model.endIndex) {
				return section;
			}
		}
		// 理论上来说，不存在会找不到的情况，如果真出现了，肯定属于哪里出问题了
		return -1;
	}
}

/// SectionList的Section数据模型
class _SectionModel {
	
	// 整个section的起始偏移量
	final double startY;
	// 整个section的结尾偏移量
	final double endY;
	// header的高度
	final double headerHeight;
	// 下属cell高度
	final List<double> cellsHeight;
	
	// 对应ListView的index起始位置
	final int startIndex;
	// 对应ListView的index结束位置
	final int endIndex;
	
	// 该section中有多少个item
	int get itemCount => endIndex - startIndex;
	
	_SectionModel({
		this.startY,
		this.endY,
		this.headerHeight,
		this.cellsHeight,
		this.startIndex,
		this.endIndex
	});
}