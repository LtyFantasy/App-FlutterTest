
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/review_avatar_list.dart';
import 'package:my_flutter/tools/ui_screen.dart';

class ProfileReviewWidget extends StatefulWidget {
	
	ProfileReviewWidget({
		Key key,
	}) : super(key: key);

	@override
  State<StatefulWidget> createState() {
    return ProfileReviewWidgetState();
  }
}

class ProfileReviewWidgetState extends State<ProfileReviewWidget> {
	
	static double height = dp(130);
	static double width = dp(306);
	
	/// 中间间距
	static const double _midPadding = 6.0;
	
	/// 卡片宽度
	static double _cardWidth = (width - _midPadding) / 2.0;
	
	/// 卡片高度
	static double _cardHeight = height;
	
	/// Out卡片
	Widget _out;
	
	/// OutListKey
	GlobalKey<ReviewAvatarListState> _outListKey;
	
	/// In卡片
	Widget _in;
	
	/// InListKey
	GlobalKey<ReviewAvatarListState> _inListKey;
	
	/// 字体
	static const TextStyle textStyle = const TextStyle(
			fontSize: 36,
			fontWeight: FontWeight.bold,
			color: Colors.white
	);
	
	@override
  void initState() {
    
    super.initState();

    _outListKey = GlobalKey<ReviewAvatarListState>();
    _inListKey = GlobalKey<ReviewAvatarListState>();
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
			child: ClipRRect(
				clipBehavior: Clip.hardEdge,
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(_cardHeight / 2.0),
					bottomLeft: Radius.circular(_cardHeight / 2.0),
					topRight: Radius.circular(dp(10)),
					bottomRight: Radius.circular(dp(10)),
				),
				child: Container(
						alignment: Alignment.topRight,
						width: _cardWidth,
						height: _cardHeight,
						decoration: const BoxDecoration(
								color: Colors.deepOrange,
						),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							crossAxisAlignment: CrossAxisAlignment.end,
							children: <Widget>[
								Container(
									margin: EdgeInsets.only(top: dp(10), right: dp(15)),
									child: const Text("OUT", style: textStyle),
								),
								Container(
									margin: EdgeInsets.only(right: dp(5), bottom: dp(10)),
									child: ReviewAvatarList(
										key: _outListKey,
										avatarSize: dp(44),
										avatarPadding: EdgeInsets.only(right: dp(10)),
										reverse: true,
									),
								)
							],
						)
				),
			)
		);
	}
	
	Widget _createInCard() {
		
		return RepaintBoundary(
			child: ClipRRect(
				clipBehavior: Clip.hardEdge,
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(dp(10)),
					bottomLeft: Radius.circular(dp(10)),
					topRight: Radius.circular(_cardHeight / 2.0),
					bottomRight: Radius.circular(_cardHeight / 2.0),
				),
				child: Container(
					alignment: Alignment.topLeft,
					width: _cardWidth,
					height: _cardHeight,
					decoration: const BoxDecoration(
							color: Colors.greenAccent,
					),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Container(
								margin: EdgeInsets.only(top: dp(10), left: dp(20)),
								child: const Text("IN", style: textStyle),
							),
							Container(
								margin: EdgeInsets.only(left: dp(5), bottom: dp(10)),
								child: ReviewAvatarList(
									key: _inListKey,
									avatarSize: dp(44),
									avatarPadding: EdgeInsets.only(left: dp(10)),
									reverse: false,
								),
							)
						],
					),
				),
			),
		);
	}
}