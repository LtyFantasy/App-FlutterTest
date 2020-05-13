
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/review_avatar_list.dart';

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
	
	static const double height = 130.0;
	static const double width = 306.0;
	
	/// 中间间距
	static const double _midPadding = 6.0;
	
	/// 卡片宽度
	static const double _cardWidth = (width - _midPadding) / 2.0;
	
	/// 卡片高度
	static const double _cardHeight = height;
	
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
				borderRadius: const BorderRadius.only(
					topLeft: const Radius.circular(_cardHeight / 2.0),
					bottomLeft: const Radius.circular(_cardHeight / 2.0),
					topRight: const Radius.circular(10.0),
					bottomRight: const Radius.circular(10.0),
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
									margin: const EdgeInsets.only(top: 10.0, right: 15.0),
									child: const Text("OUT", style: textStyle),
								),
								Container(
									margin: const EdgeInsets.only(right: 5.0, bottom: 10.0),
									child: ReviewAvatarList(
										key: _outListKey,
										avatarSize: 44.0,
										avatarPadding: EdgeInsets.only(right: 10.0),
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
				borderRadius: const BorderRadius.only(
					topLeft: const Radius.circular(10.0),
					bottomLeft: const Radius.circular(10.0),
					topRight: const Radius.circular(_cardHeight / 2.0),
					bottomRight: const Radius.circular(_cardHeight / 2.0),
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
								margin: const EdgeInsets.only(top: 10.0, left: 20.0),
								child: const Text("IN", style: textStyle),
							),
							Container(
								margin: const EdgeInsets.only(left: 5.0, bottom: 10.0),
								child: ReviewAvatarList(
									key: _inListKey,
									avatarSize: 44.0,
									avatarPadding: EdgeInsets.only(left: 10.0),
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