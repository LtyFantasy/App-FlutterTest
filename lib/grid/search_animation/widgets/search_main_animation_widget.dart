
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_animation_photo.dart';

class SearchMainAnimationWidget extends StatefulWidget {
	
	/// 动画结束回调
	final VoidCallback animationDone;
	
	SearchMainAnimationWidget({
		Key key,
		this.animationDone
	}) : super(key: key);
	
	@override
  State<StatefulWidget> createState() {
    return SearchMainAnimationWidgetState();
  }
}

class SearchMainAnimationWidgetState extends State<SearchMainAnimationWidget> {
	
	/// flare控制器
  SearchFlareControls _flareController;
	
	/// 主要头像的key
	GlobalKey<SearchAnimationPhotoState> _mainPhoto = GlobalKey();
	
	/// 其他头像
	List<String> _randomPhotos;
	
	/// 其他头像的key
	List<GlobalKey<SearchAnimationPhotoState>> _randomPhotoKeys;
	
	/// 其他头像的分布位置
	List<SearchRandomPosition> _randomPositions;
	
	///--------------------- 预先准备的Widget -----------------------
	
	/// 背景Flare
	FlareActor _bgFlare;
	
	/// 主头
	SearchAnimationPhoto _mainPhotoWidget;
	
	///
	List<Widget> _otherPhotosWidget;
	
	
	@override
  void initState() {
		
    super.initState();
    
		_flareController = SearchFlareControls(completeCallback: (name) {
			
			if (name == "Zoomin") {
				_startPhotoAnimation();
			}
			else if (name == "Zoomout") {
				widget.animationDone();
			}
    });
		
		// 背景Flare
		_bgFlare = FlareActor(
			"asset/flare/WooPlusMap.flr",
			alignment: Alignment.topCenter,
			controller: _flareController,
			sizeFromArtboard: true,
		);
		
		_flareController.play("Nothing");
		
		// 主头
		_mainPhotoWidget = SearchAnimationPhoto(
			key: _mainPhoto,
			sourcePath: "asset/search_animation/avatar.jpg",
			size: 130,
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
		children.add(_bgFlare);
		children.add(_mainPhotoWidget);
		children.addAll(_otherPhotosWidget);
		
		return Container(
			width: 350,
			height: 350,
			child: Stack(
				alignment: Alignment.center,
				children: children,
			),
		);
  }
  
  void startAnimation() {
	
		// 开启Flare动画
		_flareController.play("Zoomin");
		Future.delayed(Duration(milliseconds: 4200), () {
			_flareController.play("Zoomout");
		});
	}
	
	void _startPhotoAnimation() {
		
		// 启动主要头像动画
		_mainPhoto.currentState.startAnimation();
		// 启动其它头像动画
		for (int i = 0; i < _randomPhotos.length && i < _randomPositions.length; i++) {
			Future.delayed(Duration(milliseconds: _randomPositions[i].delayMS), () {
				_randomPhotoKeys[i].currentState.startAnimation();
			});
		}
	}
  
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
		return const [
			const SearchRandomPosition(right: 30, bottom: 130, size: 60, delayMS: 200),
			const SearchRandomPosition(left:130, top: 50, size: 40, delayMS: 400),
			const SearchRandomPosition(right: 120, bottom: 25 ,size: 70, delayMS: 600),
			const SearchRandomPosition(left:50, bottom: 90, size: 50, delayMS: 900),
			const SearchRandomPosition(left:45, top: 75, size: 75, delayMS: 1400),
			const SearchRandomPosition(right: 80, top: 50, size: 70, delayMS: 1800),
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