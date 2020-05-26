
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_animation_photo.dart';
import 'package:my_flutter/tools/ui_screen.dart';

/// 用户头像搜索雷达图动画
///
/// 有2种情况：
/// 1，已经有定位权限时，动画顺畅从头到尾做完，并消失
/// 2，无定位权限时，动画执行到一半先暂停，通知业务层进行权限获取，权限获取完毕后，再继续动画
class SearchMainAnimationWidget extends StatefulWidget {
	
	/// 定位授权是否已经询问过
	final bool hasAskLocationPermission;
	
	/// 动画暂停回调，用于获取定位授权时
	final VoidCallback animationSuspended;
	
	/// 动画结束回调
	final VoidCallback animationDone;
	
	SearchMainAnimationWidget({
		Key key,
		this.hasAskLocationPermission,
		this.animationSuspended,
		this.animationDone,
	}) : super(key: key);
	
	@override
  State<StatefulWidget> createState() {
    return SearchMainAnimationWidgetState();
  }
}

class SearchMainAnimationWidgetState extends State<SearchMainAnimationWidget> {
	
	/// Flare动画名
	String _animation = "Zoomin";
	
	/// 主要头像的key
	GlobalKey<SearchAnimationPhotoState> _mainPhoto = GlobalKey();
	
	/// 其他头像
	List<String> _randomPhotos;
	
	/// 其他头像的key
	List<GlobalKey<SearchAnimationPhotoState>> _randomPhotoKeys;
	
	/// 其他头像的分布位置
	List<SearchRandomPosition> _randomPositions;
	
	///--------------------- 预先准备的Widget -----------------------
	
	/// 主头
	SearchAnimationPhoto _mainPhotoWidget;
	
	/// 其他头像
	List<Widget> _otherPhotosWidget;
	
	@override
  void initState() {
		
    super.initState();

		// 主头
		_mainPhotoWidget = SearchAnimationPhoto(
			key: _mainPhoto,
			sourcePath: "asset/search_animation/avatar.jpg",
			size: dp(130),
			isMainPhoto: true,
		);
  
		// 创建随机头像，并生成对应的位置数据
    _randomPhotos = _createPhotoSource();
		_randomPositions = _createPositions();

		_randomPhotoKeys = [];
    for (int i = 0; i < _randomPhotos.length; i++) {
    	_randomPhotoKeys.add(GlobalKey());
		}
    
    _otherPhotosWidget = _createRandomPhotos();
  }
	
	@override
  Widget build(BuildContext context) {
		
		List<Widget> children = [];
		children.add(FlareActor(
			"asset/flare/WooPlusMap.flr",
			animation: _animation,
			alignment: Alignment.topCenter,
			callback: (name) {
				
				if (name == "Zoomin") {
					
					_startPhotoAnimation(widget.hasAskLocationPermission);
					// 有定位权限的时候，才自动延迟消失
					// 无权限的时候，要等待权限选择完毕后，再手动调用消失
					if (widget.hasAskLocationPermission) {
						Future.delayed(Duration(milliseconds: 3800), () {
							if (mounted) {
								setState(() {
									_animation = "Zoomout";
								});
							}
						});
					}
				}
				else if (name == "Zoomout") {
					widget.animationDone();
				}
			},
		));
		children.add(_mainPhotoWidget);
		children.addAll(_otherPhotosWidget);
		
		return Container(
			width: dp(350),
			height: dp(350),
			child: Stack(
				alignment: Alignment.center,
				children: children,
			),
		);
  }
  
  /// 开始动画执行
	///
	/// 视[widget.hasLocationPermission]而定，会有不同的方案
  void startAnimation() {
		
		if (mounted) {
			setState(() {
				_animation = "Zoomin";
			});
		}
	}
	
	/// 继续动画
	///
	/// 适用于[widget.hasLocationPermission]为false时
	/// 授权弹框，用户操作后，再继续动画
	void resumeAnimation() {
	
		List<Future> futures = [];
		
		_mainPhoto.currentState.resumeAnimation();
		for (int i = 0; i < _randomPhotos.length &&
				i < _randomPositions.length; i++) {
			
			Future future = Future.delayed(Duration(milliseconds: _randomPositions[i].delayMS), () {
				if (i < 4) {
					_randomPhotoKeys[i].currentState.resumeAnimation();
				}
				else {
					_randomPhotoKeys[i].currentState.startAnimation();
				}
			});
			futures.add(future);
		}
		
		Future.wait(futures).then((value) {
			Future.delayed(Duration(milliseconds: 1800), (){
				if (mounted) {
					setState(() {
						_animation = "Zoomout";
					});
				}
			});
		});
	}
	
	/// 启动所有头像的动画
	///
	/// 有定位权限的时候，所有头像做连贯全套动画
	/// 无定位权限的时候，先前几个头像仅展现，随后等用户权限选择完毕后，再进行剩余的动画
	void _startPhotoAnimation(bool hasAskLocationPermission) {
		
		// 启动主要头像动画
		_mainPhoto.currentState.startAnimation(isNormal: hasAskLocationPermission);
		
		List<Future> futures = [];
		
		// 有权限时，所有其他头像都正常动画运作
		if (hasAskLocationPermission) {
			for (int i = 0; i < _randomPhotos.length &&
					i < _randomPositions.length; i++) {
				Future future = Future.delayed(Duration(milliseconds: _randomPositions[i].delayMS), () {
					_randomPhotoKeys[i].currentState.startAnimation();
				});
				futures.add(future);
			}
		}
		// 无权限时，先启动前4个
		else {
			
			for (int i = 0; i < 4 && i < _randomPhotos.length &&
					i < _randomPositions.length; i++) {
				Future future = Future.delayed(Duration(milliseconds: _randomPositions[i].delayMS), () {
					_randomPhotoKeys[i].currentState.startAnimation(isNormal: false);
				});
				futures.add(future);
			}
		}
		
		Future.wait(futures).then((value) {
			
			if (hasAskLocationPermission) {
				Future.delayed(Duration(milliseconds: 1800), () {
					if (mounted) {
						setState(() {
							_animation = "Zoomout";
						});
					}
				});
			}
			else {
				if (widget.animationSuspended != null) {
					widget.animationSuspended();
				}
			}
		});
	}
 
	/// 创建随机头像
  List<Widget> _createRandomPhotos() {
		
		List<Widget> list = [];
		for (int i = 0; i < _randomPhotos.length && i < _randomPositions.length; i++) {
			
			SearchRandomPosition position = _randomPositions[i];
			list.add(Positioned(
				top: position.top,
				bottom: position.bottom,
				left: position.left,
				right: position.right,
				child: SearchAnimationPhoto(
					key: _randomPhotoKeys[i],
					sourcePath: _randomPhotos[i],
					size: position.size,
				),
			));
		}
		return list;
	}
	
	/// 生成随机头像组，真随机
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
	
	/// 生成伪随机位置数据
	///
	/// 数据都是经过布局测试的写死数据
	List<SearchRandomPosition> _createPositions() {
		return [
			SearchRandomPosition(right: dp(30), bottom: dp(130), size: dp(60), delayMS: 200),
			SearchRandomPosition(left:dp(130), top: dp(50), size: dp(40), delayMS: 400),
			SearchRandomPosition(right: dp(120), bottom: dp(25) ,size: dp(70), delayMS: 600),
			SearchRandomPosition(left:dp(50), bottom: dp(90), size: dp(50), delayMS: 900),
			SearchRandomPosition(left:dp(45), top: dp(75), size: dp(75), delayMS: 1400),
			SearchRandomPosition(right: dp(80), top: dp(50), size: dp(70), delayMS: 1800),
		];
	}
}

/// 图片布局数据
///
/// 表示了图片显示的位置，大小，动画启动延时
class SearchRandomPosition {
	
	final double top;
	final double bottom;
	final double left;
	final double right;
	final double size;
	final int delayMS;
	
	const SearchRandomPosition({
		this.top,
		this.bottom,
		this.left,
		this.right,
		this.size,
		this.delayMS
	});
}

/// 自定义FlareController
class SearchFlareControls extends FlareControls {
	
  /// 完成回调
  final void Function(String name) completeCallback;

  SearchFlareControls({this.completeCallback});
  
  @override
  void onCompleted(String name) {
    completeCallback(name);
  }
}