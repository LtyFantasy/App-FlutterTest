import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/profile_review_widget.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/review_avatar_list.dart';
import 'package:my_flutter/grid/in_out_animation/widgets/review_challenge_list.dart';
import 'package:my_flutter/tools/ui_screen.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(InOutAnimationState state, Dispatch dispatch, ViewService viewService) {
  
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      brightness: Brightness.light,
      title: Text(""),
      elevation: 0,
      leading: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          FocusScope.of(viewService.context).requestFocus(FocusNode());
          Navigator.pop(viewService.context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(viewService.context).iconTheme.color,
        ),
      ),
      actions: <Widget>[
        IconButton(
          color: Colors.red,
          icon: const Icon(Icons.looks_one),
          onPressed: () {
            state.profileReviewKey.currentState.insert(
                model: ReviewAvatarModel("asset/search_animation/avatar.jpg"),
                isOut: true
            );
          },
        ),
        IconButton(
          color: Colors.red,
          icon: const Icon(Icons.looks_two),
          onPressed: () {
            state.profileReviewKey.currentState.insert(
                model: ReviewAvatarModel("asset/search_animation/avatar.jpg"),
                isOut: false
            );
          },
        ),
        IconButton(
          color: Colors.red,
          icon: const Icon(Icons.looks_3),
          onPressed: () {
            
            state.challengeListKey.currentState.insert(ReviewChallengeModel(
              id: "111",
              name: "KissMeBaby",
              gender: 2
            ));
          },
        ),
        IconButton(
          color: Colors.red,
          icon: const Icon(Icons.looks_4),
          onPressed: () {
      
            state.challengeListKey.currentState.insert(ReviewChallengeModel(
                id: "111",
                name: "Laural",
                gender: 2
            ));
          },
        ),
      ],
    ),
    body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: dp(50), bottom: dp(50)),
                        child: Text(
                          "You May Enter\nWooPlus After Profile\nReview",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: dp(24),
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      ProfileReviewWidget(
                        key: state.profileReviewKey,
                      )
                    ],
                  ),
                  Container(
                    height: dp(55),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: dp(30), right: dp(30), bottom: dp(30)),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(Radius.circular(dp(55)/2.0))
                    ),
                    child: Text(
                      "Skip Review",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: dp(16)
                      ),
                    ),
                  )
                ],
              )
          ),
          Positioned(
            top: dp(20),
            bottom: dp(105),
            left: 0,
            right: 0,
            child: ReviewChallengeList(
              key: state.challengeListKey
            ),
          )
        ],
      ),
    )
  );
}
