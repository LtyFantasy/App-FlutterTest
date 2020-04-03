import 'package:fish_redux/fish_redux.dart';
import 'package:my_flutter/grid/challenge_swiper_test/widgets/challenge_swiper.dart';

class ContainerTestState implements Cloneable<ContainerTestState> {
  
  List<ChallengeSwiperItem> challengeItems;

  @override
  ContainerTestState clone() {
    return ContainerTestState()
      ..challengeItems = challengeItems;
  }
}

ContainerTestState initState(Map<String, dynamic> args) {
  
  return ContainerTestState()..challengeItems = [
    ChallengeSwiperItem(
        text: "天上人间欢迎光临",
        imagePath:"http://via.placeholder.com/288x288"
    ),
    ChallengeSwiperItem(
        text: "Call me when you lonely,Call me when you lonely,Call me when you lonely,Call me when you lonely,Call me when you lonely,Call me when you lonely,Call me when you lonely",
        imagePath:"http://via.placeholder.com/388x388"
    ),
    ChallengeSwiperItem(
        text: "澳门线上赌场开业啦~ 美女荷官在线发牌，充值就送宝石、金币、VIP~",
        imagePath:"http://via.placeholder.com/100x100"
    ),
  ];
}
