
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/review_avatar_list.dart';

class ProfileReviewWidget extends StatefulWidget {
	
	/// 宽度
	final double width;
	
	/// 高度
	final double height;
	
	ProfileReviewWidget({
		Key key,
		@required this.width,
		@required this.height
	}) : super(key: key);

	@override
  State<StatefulWidget> createState() {
    return ProfileReviewWidgetState();
  }
}

class ProfileReviewWidgetState extends State<ProfileReviewWidget> {
	
	/// Out卡片
	Widget _out;
	
	/// OutListKey
	GlobalKey<ReviewAvatarListState> _outListKey;
	
	/// In卡片
	Widget _in;
	
	/// InListKey
	GlobalKey<ReviewAvatarListState> _inListKey;
	
	/// 中间间距
	double _midPadding = 6.0;
	
	/// 卡片宽度
	double _cardWidth;
	
	/// 卡片高度
	double _cardHeight;
	
	/// 字体
	TextStyle textStyle = const TextStyle(
			fontSize: 36,
			fontWeight: FontWeight.bold,
			color: Colors.white
	);
	
	@override
  void initState() {
    
    super.initState();

    _outListKey = GlobalKey<ReviewAvatarListState>();
    _inListKey = GlobalKey<ReviewAvatarListState>();
    _cardWidth = (widget.width - _midPadding) / 2.0;
    _cardHeight = widget.height;
    _out = _createOutCard();
    _in = _createInCard();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
			child: Center(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						_out,
						Container(width: _midPadding),
						_in,
					],
				),
			),
		);
  }
  
  /// 插入数据
	///
	/// @param: model [ReviewAvatarModel]数据源
	/// @param: isOut true-插入out false-插入in
  void insert({ReviewAvatarModel model, bool isOut}) {
		
		if (isOut == true) {
			_outListKey.currentState.insert(model);
		}
		else {
			_inListKey.currentState.insert(model);
		}
	}
  
  Widget _createOutCard() {
		return RepaintBoundary(
			child: Container(
				alignment: Alignment.topRight,
				width: _cardWidth,
				height: _cardHeight,
				padding: EdgeInsets.fromLTRB(0, 10, 15, 15),
				clipBehavior: Clip.hardEdge,
				decoration: BoxDecoration(
						color: Colors.deepOrange,
						borderRadius: BorderRadius.only(
							topLeft: Radius.circular(_cardHeight / 2.0),
							bottomLeft: Radius.circular(_cardHeight / 2.0),
							topRight: const Radius.circular(10.0),
							bottomRight: const Radius.circular(10.0),
						)
				),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					crossAxisAlignment: CrossAxisAlignment.end,
					children: <Widget>[
						Text("OUT", style: textStyle),
						ReviewAvatarList(
							key: _outListKey,
							avatarSize: 44.0,
							avatarPadding: EdgeInsets.only(left: 10.0),
							reverse: true,
						)
					],
				),
			),
		);
	}
	
	Widget _createInCard() {
		return RepaintBoundary(
			child: Container(
				alignment: Alignment.topLeft,
				width: _cardWidth,
				height: _cardHeight,
				padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
				clipBehavior: Clip.hardEdge,
				decoration: BoxDecoration(
						color: Colors.greenAccent,
						borderRadius: BorderRadius.only(
							topLeft: const Radius.circular(10.0),
							bottomLeft: const Radius.circular(10.0),
							topRight: Radius.circular(_cardHeight / 2.0),
							bottomRight: Radius.circular(_cardHeight / 2.0),
						)
				),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Text("IN", style: textStyle),
						ReviewAvatarList(
							key: _inListKey,
							avatarSize: 44.0,
							avatarPadding: EdgeInsets.only(right: 10.0),
							reverse: false,
						)
					],
				),
			),
		);
	}
}