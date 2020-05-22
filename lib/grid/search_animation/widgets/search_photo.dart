
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPhoto extends StatelessWidget {
	
	/// 图片路径
	final String sourcePath;
	
	/// 大小
	final double size;
	
	/// 是否显示边框
	final bool showBorder;
	
	/// 边框宽度
	final double borderWidth;
	
	SearchPhoto({
		@required this.sourcePath,
		this.size = 44.0,
		this.showBorder = false,
		this.borderWidth = 6.0,
	});
	
	@override
  Widget build(BuildContext context) {
		
		Widget clipPhoto = ClipRRect(
			clipBehavior: Clip.hardEdge,
			borderRadius: BorderRadius.all(Radius.circular(size / 2.0)),
			child: Image.asset(sourcePath, fit: BoxFit.contain),
		);
		
		if (showBorder) {
			return Container(
				decoration: BoxDecoration(
					borderRadius: BorderRadius.all(Radius.circular(size / 2.0)),
					border: Border.all(
						color: Colors.white,
						width: borderWidth
					)
				),
				child: clipPhoto,
			);
		}
		else {
			return clipPhoto;
		}
  }
}