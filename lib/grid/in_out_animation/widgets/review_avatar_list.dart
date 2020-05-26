
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/tools/ui_screen.dart';

/// 用户逼单 Review投票头像List控件
///
/// 主要实现头像的浮现位移动效
class ReviewAvatarList extends StatefulWidget {
	
	/// 初始数据
	final List<ReviewAvatarModel> initData;
	
	/// 头像大小，默认44
	final double avatarSize;
	
	/// 头像边距，默认Left 5.0
	final EdgeInsetsGeometry avatarPadding;
	
	/// 头像描边宽度，默认4.0
	final double avatarBorderWidth;
	
	/// 每次动画的持续时间，默认600ms
	final Duration animationDuration;
	
	/// 滚动方向，默认水平
	final Axis scrollDirection;
	
	/// 滚动是否反向，默认false
	final reverse;
	
	ReviewAvatarList({
		Key key,
		this.initData,
		this.avatarSize = 44.0,
		this.avatarPadding = const EdgeInsets.only(left: 5.0),
		this.avatarBorderWidth = 4.0,
		this.animationDuration = const Duration(milliseconds: 600),
		this.scrollDirection = Axis.horizontal,
		this.reverse = false,
	}) : super(key: key);
	
	@override
	ReviewAvatarListState createState() => ReviewAvatarListState();
}

class ReviewAvatarListState extends State<ReviewAvatarList> {
	
	/// AnimatedList的Key
	final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey<AnimatedListState>();
	
	/// AnimatedListState
	AnimatedListState get _animatedList => _animatedListKey.currentState;
	
	/// 数据源
	List<ReviewAvatarModel> _listData;
	
	/// 动画时间
	Duration duration;
	
	@override
	void initState() {
		super.initState();
		initData();
	}
	
	@override
	Widget build(BuildContext context) {
		
		Widget child = AnimatedList(
			key: _animatedListKey,
			physics: NeverScrollableScrollPhysics(),
			scrollDirection: widget.scrollDirection,
			reverse: widget.reverse,
			initialItemCount: _listData.length,
			itemBuilder: _buildItem,
		);
		
		// 以下多一个 10 ，是为了保证动画阻尼放大时，不被边界裁剪
		// 如果时水平滚动，我们要给一个高度
		if (widget.scrollDirection == Axis.horizontal) {
			return Container(
				height: widget.avatarSize + dp(10),
				child: child,
			);
		}
		// 如果是垂直滚动，我们要给一个宽度
		else {
			return Container(
				width: widget.avatarSize + dp(10),
				child: child,
			);
		}
	}
	
	/// 数据初始化
	void initData() {
		_listData = widget.initData == null ? [] : List.from(widget.initData);
		duration = widget.animationDuration ?? Duration(milliseconds: 600);
	}
	
	/// 新增头部数据
	void insert(ReviewAvatarModel model) {
		_listData.insert(0, model);
		_animatedList.insertItem(0, duration: duration);
	}
	
	/// 移除头部数据
	ReviewAvatarModel remove() {
		
		if (_listData.length == 0) {
			return null;
		}
		
		ReviewAvatarModel removedItem = _listData.removeAt(0);
		_animatedList.removeItem(0, (BuildContext context, Animation<double> animation) {
			return _buildRemovedItem(removedItem, context, animation);
		}, duration: duration);
		
		if (mounted) {
			setState(() {});
		}
		
		return removedItem;
	}
	
	/// 创建Item
	Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
		return ReviewAvatarItem(
			animation: animation,
			model: _listData[index],
			size: widget.avatarSize,
			padding: widget.avatarPadding,
			borderSize: widget.avatarBorderWidth,
		);
	}
	
	/// 创建移除动画专用的Item
	Widget _buildRemovedItem(ReviewAvatarModel model, BuildContext context, Animation<double> animation) {
		return ReviewAvatarItem(
			animation: animation,
			model: model,
			size: widget.avatarSize,
			padding: widget.avatarPadding,
			borderSize: widget.avatarBorderWidth,
		);
	}
}

/// 头像数据Model
class ReviewAvatarModel {
	
	/// 头像地址
	final String sourcePath;
	
	/// 获取对应的控件
	Widget get widget {
		return (sourcePath != null && sourcePath.length > 0)
				? Image.asset(sourcePath, fit: BoxFit.contain)
				: Container();
	}
	
	ReviewAvatarModel(this.sourcePath);
}

/// 头像Item组件
class ReviewAvatarItem extends StatelessWidget {
	
	/// 动画值
	final Animation<double> animation;
	
	/// 数据源
	final ReviewAvatarModel model;
	
	/// 大小
	final double size;
	
	/// 边距
	final EdgeInsetsGeometry padding;
	
	/// 描边宽度
	final double borderSize;
	
	const ReviewAvatarItem({
		Key key,
		@required this.model,
		@required this.animation,
		this.size = 44.0,
		this.padding = const EdgeInsets.only(left: 5.0),
		this.borderSize = 4.0
	}) :
		assert(animation != null),
		assert(model != null),
		super(key: key);
	
	@override
	Widget build(BuildContext context) {

		return InOutTransition(
				animation: animation,
				child: Padding(
					padding: padding,
					child: Container(
						alignment: Alignment.center,
						child: SizedBox(
							height: size,
							width: size,
							child: Container(
								decoration: BoxDecoration(
										borderRadius: BorderRadius.all(Radius.circular(size/2.0)),
										border: Border.all(
											color: Colors.white,
											width: borderSize
										)
								),
								child: Center(
									child: ClipOval(
										child: model.widget,
									)
								),
							),
						),
					),
				),
		);
	}
}

/// 头像InOut出现动画
///
/// 为了达到UI效果，动画分2段
/// 1，位移，贯穿全时间轴
/// 2，缩放，时间轴从0.2到1，阻尼效果
class InOutTransition extends AnimatedWidget {
	
	/// 位移动画曲线
	static const Cubic sizeCurve = Curves.fastLinearToSlowEaseIn;
	
	/// 缩放动画曲线
	static const ElasticOutCurve scaleCurve = const ElasticOutCurve(0.5);
	
	/// 动画时间值监听
	Animation<double> get animationFactor => listenable as Animation<double>;
	
	/// 被做动画的控件
	final Widget child;

	const InOutTransition({
		Key key,
		@required Animation<double> animation,
		this.child
	}) :
		assert(animation != null),
		super(key: key, listenable: animation);
	
	@override
	Widget build(BuildContext context) {
		
		// 位移计算
		double sizeFactor = math.max(animationFactor.value, 0.0);
		sizeFactor = sizeCurve.transformInternal(sizeFactor);
		
		// 缩放计算，时间区间0.2-1.0
		double scaleValue = animationFactor.value;
		scaleValue = scaleRegionCal(0.2, 1.0, scaleValue);
		// 阻尼效果
		scaleValue = scaleCurve.transformInternal(scaleValue);
		// 缩放矩阵
		final Matrix4 transform = Matrix4.identity()
			..scale(scaleValue, scaleValue, 1.0);

		return Align(
			alignment: Alignment.center,
			heightFactor: sizeFactor,
			widthFactor: sizeFactor,
			child: Transform(
				transform: transform,
				alignment: Alignment.center,
				child: child,
			),
		);
	}
	
	/// 区间运动Path计算
	///
	/// 正常情况下，一个值应该从时间0.0到1.0期间，是匀速线性增长的
	/// 但是某些效果，希望其仅仅在某些时间段内才开始线性增长
	/// 比如：0.2-1.0期间，缩放才开始动画（值从0.0到1.0），0.2以前，缩放都保持0
	///
	/// @param: start 时间开始值
	/// @param: end 时间结束值
	/// @param: current 当前动画运行到的时间值
	/// @return: 变化结果值
	double scaleRegionCal(double start, double end, double current) {
		
		if (current < start) return 0;
		if (start >= end) return 1;
		
		// 解二元一次方程
		// a * start + b = 0;
		// a * end + b = 1;
		// b = -start * a;
		// a = 1 / (end - start);
		double a = 1 / (end - start);
		double b = -start * a;
		return a * current + b;
	}
}

