
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

/// 用户挑战滑动卡片控件
///
/// 本控件使用了第三方插件flutter_swiper
/// 初始化时，会先续接flare加载动画，然后代码呈现一个从小放大的动画，最后再进行实际控件展示
///
/// Author: Loki
/// CreateDate: 2020/4/1

/// Item数据构造器
typedef ChallengeSwiperItemBuilder = ChallengeSwiperItem Function(int index);
/// 数据源对象
class ChallengeSwiperItem {
	
	/// 卡片文本，显示在卡片底部，最多3行
	final String text;
	/// 卡片背景图片
	final String imagePath;
	
	ChallengeSwiperItem({this.text, this.imagePath});
}

/// 用户挑战，选择挑战时的滑动卡片列表控件
class ChallengeSwiper extends StatelessWidget {
	
	/// 卡片的大小
	final double itemSize;
	/// 是否初始化开启缩放动画，默认true
	final bool enableStartAnimation;
	/// Index改变时回调
	final ValueChanged<int> onIndexChanged;
	/// Item个数
	final int itemCount;
	/// Item的图片数据源
	final ChallengeSwiperItemBuilder itemBuilder;
	
	ChallengeSwiper({
		Key key,
		this.itemSize = 250.0,
		this.enableStartAnimation = true,
		this.onIndexChanged,
		this.itemCount = 0,
		@required this.itemBuilder,
	}) : assert(itemBuilder != null, "[ChallengeSwiper] itemBuilder can't be null"),
			super(key: key);
	
	@override
  	Widget build(BuildContext context) {
    
    	return Swiper(
			itemCount: itemCount,
			viewportFraction: 0.70,
			scale: 0.8,
			outer: true,
			loop: false,
			onIndexChanged: onIndexChanged,
			pagination: SwiperPagination(
				margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
				builder: DotSwiperPaginationBuilder(
					color: Color.fromARGB(255, 216, 216, 216),
					activeColor: Colors.deepOrange,
					space: 5
				)
			),
			itemBuilder: (BuildContext context, int index) {
			
				ChallengeSwiperItem itemData = itemBuilder(index);
				return _createChallengeItemCard(
					itemSize: itemSize,
					itemData: itemData,
				);
			},
		);
  	}
}

/// 创建ItemCard控件
Widget _createChallengeItemCard({@required double itemSize, @required ChallengeSwiperItem itemData}) {
	
	return Container(
		alignment: Alignment.topCenter,
		child: SizedBox(
			width: itemSize,
			height: itemSize,
			child: ClipRRect(
				borderRadius: BorderRadius.all(Radius.circular(14.0)),
				clipBehavior: Clip.hardEdge,
				child: Stack(
					alignment: Alignment.topCenter,
					children: <Widget>[
						Positioned(
							width: itemSize,
							height: itemSize,
							child: Image.network(
								itemData.imagePath,
								fit: BoxFit.fill,
							),
						),
						Positioned(
							left: 0,
							right: 0,
							bottom: 0,
							child: Container(
								padding: EdgeInsets.all(8.0),
								color: Colors.black.withAlpha(80),
								constraints: BoxConstraints(
									minHeight: 64
								),
								child: Center(
									child: Text(
										itemData.text,
										textAlign: TextAlign.center,
										overflow: TextOverflow.ellipsis,
										maxLines: 3,
										style: TextStyle(
											fontSize: 16.0,
											fontWeight: FontWeight.bold,
											color: Colors.white
										),
									)
								),
							),
						)
					],
				)
			),
		),
	);
}