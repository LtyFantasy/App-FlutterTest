
import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/profile_review_widget.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/review_avatar_list.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/review_challenge_list.dart';
import 'package:my_flutter/store/state.dart';

class InOutAnimationState implements GlobalBaseState, Cloneable<InOutAnimationState> {
  
  @override
  Color themeColor;
  
  GlobalKey<ProfileReviewWidgetState> profileReviewKey;
  List<ReviewAvatarModel> outData;
  List<ReviewAvatarModel> intData;
  
  GlobalKey<ReviewChallengeListState> challengeListKey;
  
  @override
  InOutAnimationState clone() {
    return InOutAnimationState()
      ..themeColor = themeColor
      ..profileReviewKey = profileReviewKey
      ..outData = outData
      ..intData = intData;
  }
}

InOutAnimationState initState(Map<String, dynamic> args) {
  return InOutAnimationState()
    ..profileReviewKey = GlobalKey<ProfileReviewWidgetState>()
    ..challengeListKey = GlobalKey<ReviewChallengeListState>()
    ..outData = [
      ReviewAvatarModel("0"),
      ReviewAvatarModel("1"),
      ReviewAvatarModel("2"),
    ]
    ..intData = [
      ReviewAvatarModel("0"),
      ReviewAvatarModel("1"),
      ReviewAvatarModel("2"),
    ];
}
