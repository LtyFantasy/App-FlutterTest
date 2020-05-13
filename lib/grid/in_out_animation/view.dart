import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/profile_review_widget.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/review_avatar_list.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(InOutAnimationState state, Dispatch dispatch, ViewService viewService) {
  
  return Scaffold(
    appBar: AppBar(
      title: Text("InOutAnimation"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.looks_one),
          onPressed: () {
            state.profileReviewKey.currentState.insert(
              model: ReviewAvatarModel("out"),
              isOut: true
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.looks_two),
          onPressed: () {
            state.profileReviewKey.currentState.insert(
                model: ReviewAvatarModel("in"),
                isOut: false
            );
          },
        ),
      ],
    ),
    body: SafeArea(
      child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80.0, bottom: 50.0),
                    child: Text(
                      "You May Enter\nWooPlus After Profile\nReview",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ProfileReviewWidget(
                    key: state.profileReviewKey,
                    height: 130,
                    width: 306,
                  )
                ],
              ),
              Container(
                width: 315.0,
                height: 55,
                color: Colors.deepOrange,
              )
            ],
          )
      ),
    )
  );
}
