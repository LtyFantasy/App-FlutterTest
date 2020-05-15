
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/search_photo.dart';

class SearchGridAnimationList extends StatefulWidget {
	
	SearchGridAnimationList({Key key}) : super(key: key);
	
	@override
  State<StatefulWidget> createState() {
    return SearchGridAnimationListState();
  }
}

class SearchGridAnimationListState extends State<SearchGridAnimationList> {
	
	List<String> _randomPhotos;
	
	@override
  void initState() {
		
    super.initState();
    _randomPhotos = _createPhotoSource();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
	
	@override
  Widget build(BuildContext context) {
		
    return GridView.builder(
			scrollDirection: Axis.horizontal,
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
		);
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
