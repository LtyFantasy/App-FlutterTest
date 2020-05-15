
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_photo.dart';

/// 用户逼单，Search界面的动画头像控件
///
/// 使用简单，仅需要赋值图片路径，并控制动画开始即可
class SearchAnimationPhoto extends StatefulWidget {
	
	/// 是否是中间的主要头像
	///
	/// 如果为false，表明是周边随机显示的次要头像
	/// 这两种头像的显示与动画效果不同
	final bool isMainPhoto;
	
	/// 图片地址
	final String sourcePath;
	
	/// 大小
	final double size;
	
	const SearchAnimationPhoto({
		Key key,
		this.isMainPhoto = false,
		@required this.sourcePath,
		@required this.size,
	}) : super(key: key);
	
	@override
  State<StatefulWidget> createState() {
    return SearchAnimationPhotoState();
  }
}

class SearchAnimationPhotoState
		extends State<SearchAnimationPhoto> with TickerProviderStateMixin {
	
	/// 缩放控制器
	AnimationController _controllerScale;
	Animation<double> _scaleAnimation;
	
	/// 弹动控制器
	AnimationController _controllerBounce;
	Animation<double> _bounceAnimation;
	
	/// 弹动次数
	final int _bounceTimes = 2;
	int _bounceCount = 0;
	
	@override
  void initState() {
		
    super.initState();
  	_scaleAnimationInit();
  	_bounceAnimationInit();
  }
  
  @override
  void dispose() {
		_controllerScale.dispose();
		_controllerBounce.dispose();
    super.dispose();
  }
	
	@override
  Widget build(BuildContext context) {
  
		return ScaleTransition(
			scale: _scaleAnimation,
			child: ScaleTransition(
				scale: _bounceAnimation,
				child: Container(
					width: widget.size,
					height: widget.size,
					child: SearchPhoto(
						sourcePath: widget.sourcePath,
						size: widget.size,
						showBorder: widget.isMainPhoto,
					),
				),
			),
		);
  }
  
  /// 开启动画
	void startAnimation() {
		_bounceCount = 0;
		_controllerScale.forward();
	}
  
  /// 缩放动画初始化
  void _scaleAnimationInit() {
	
		_controllerScale = AnimationController(
				duration: Duration(milliseconds: 400),
				vsync: this
		)..addStatusListener((AnimationStatus status) {
			
			if (status == AnimationStatus.completed) {
				
				// 主要头像才有二段动画
				if (widget.isMainPhoto) {
					Future.delayed(Duration(milliseconds: 600), () {
						if (mounted) _controllerBounce.forward();
					});
				}
				// 其它头像，展示一会就自动消失
				else {
					Future.delayed(Duration(milliseconds: 1000), () {
						if (mounted) _controllerScale.reverse();
					});
				}
			}
			else if (status == AnimationStatus.dismissed) {
			
			}
		});
	
		CurvedAnimation curve = CurvedAnimation(
				parent: _controllerScale,
				curve: Curves.easeInOut
		);
	
		_scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
	}
	
	/// 弹动动画初始化
	void _bounceAnimationInit() {
		
		_controllerBounce = AnimationController(
				duration: Duration(milliseconds: 150),
				vsync: this
		)..addStatusListener((AnimationStatus status) {
			
			if (status == AnimationStatus.completed) {
				
				if (mounted) {
					_controllerBounce.reverse();
					_bounceCount++;
				}
			}
			else if (status == AnimationStatus.dismissed) {
				
				if (_bounceCount < _bounceTimes) {
					Future.delayed(Duration(milliseconds: 1000), () {
						if (mounted) _controllerBounce.forward();
					});
				}
				else {
					Future.delayed(Duration(milliseconds: 800), () {
						if (mounted) _controllerScale.reverse();
					});
				}
			}
		});
		
		CurvedAnimation curve = CurvedAnimation(
				parent: _controllerBounce,
				curve: Curves.easeInOut
		);
		
		_bounceAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(curve);
	}
}
