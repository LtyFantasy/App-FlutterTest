
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_photo.dart';
import 'package:my_flutter/grid/search_animation/widgets/shift_opacity_transition.dart';

class SearchGridAnimationList extends StatefulWidget {
	
	/// 动画完成回调
	final VoidCallback animationCompleteCallback;
	
	SearchGridAnimationList({
		Key key,
		this.animationCompleteCallback
	}) : super(key: key);
	
	@override
  State<StatefulWidget> createState() {
    return SearchGridAnimationListState();
  }
}

class SearchGridAnimationListState
		extends State<SearchGridAnimationList> with SingleTickerProviderStateMixin {
	
	/// 随机头像
	List<String> _randomPhotos;
	
	/// ScrollView控制器
	ScrollController _scrollController;
	
	/// 动画控制器
	AnimationController _animationController;
	
	/// 动画
	Animation<double> _animation;
	
	@override
  void initState() {
		
    super.initState();
    _randomPhotos = _createPhotoSource();
    _scrollController = ScrollController();
    
    _animationController = AnimationController(duration:Duration(milliseconds: 1000), vsync: this);
    _animationController.addStatusListener((status) {
    	
    	if (status == AnimationStatus.completed) {
    		
    		widget.animationCompleteCallback();
    		
				// 写个一次性的就行了，用户不可能真在这等10分钟
				_scrollController.animateTo(
						_scrollController.offset + 6000,
						duration: Duration(seconds: 600),
						curve: Curves.linear
				);
			}
		});
    
    CurvedAnimation curve = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curve);
  }
  
  @override
  void dispose() {
		_scrollController.dispose();
		_animationController.dispose();
    super.dispose();
  }
	
	@override
  Widget build(BuildContext context) {
		
    return ShiftOpacityTransition(
			animation: _animation,
			insetsMaker: (double value) {
				return EdgeInsets.only(left: 200 * (1 - value));
			},
			child: GridView.builder(
				controller: _scrollController,
				scrollDirection: Axis.horizontal,
				padding: const EdgeInsets.only(left: 20),
				physics: NeverScrollableScrollPhysics(),
				gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
					maxCrossAxisExtent: 90,
					childAspectRatio: 1,
					mainAxisSpacing: 15,
					crossAxisSpacing: 20,
				),
				itemBuilder: (BuildContext context, int index) {
					
					// 循环生成
					index = index % _randomPhotos.length;
					return SearchPhoto(
						sourcePath: _randomPhotos[index],
						size: 90,
					);
				},
			),
		);
  }
  
  /// 开启动画
  void startAnimation() {
		
		_animationController.forward();
	}
	
	/// 生成随机头像组，真随机
	///
	/// TODO 一次性生成几十个随机头像
	List<String> _createPhotoSource() {
		return [
			"asset/search_animation/avatar.jpg",
			"asset/search_animation/avatar.jpg",
			"asset/search_animation/avatar.jpg",
			"asset/search_animation/avatar.jpg",
			"asset/search_animation/avatar.jpg",
			"asset/search_animation/avatar.jpg",
		];
	}
}


