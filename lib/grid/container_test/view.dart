import 'package:fish_redux/fish_redux.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/container_test/widgets/challenge_prepare.dart';
import 'package:my_flutter/grid/container_test/widgets/challenge_swiper.dart';
import 'dart:ui';

import 'action.dart';
import 'state.dart';

Widget buildView(ContainerTestState state, Dispatch dispatch, ViewService viewService) {
  
    Color color = Color.fromARGB(255, 248, 248, 248);
    
    return Scaffold(
        backgroundColor: color,
        appBar: AppBar(
            backgroundColor: color,
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
        ),
        body: SafeArea(
            child: _ChallengeMainWidget(
                state: state,
            ),
        )
  );
}

/// 挑战选择页面主Widget
///
/// 该控件包含的内容包含2部分:
/// 1，初入该场景时的准备阶段，_createPrepareWidget
/// 2，挑战卡片选择阶段，_createChallengeWidget
class _ChallengeMainWidget extends StatefulWidget {
    
    final ContainerTestState state;
    bool isPrepareDone = false;

    _ChallengeMainWidget({
        this.state,
    });
    
    @override
    State<StatefulWidget> createState() => _ChallengeMainWidgetState();
}

class _ChallengeMainWidgetState extends State<_ChallengeMainWidget> {
    
    @override
    Widget build(BuildContext context) {
    
    	if (widget.isPrepareDone) {
			return _createChallengeWidget(state: widget.state);
		}
    	else {
    		return ChallengePrepare(
				loadingDoneCallback: () {
					setState(() {
					  	//widget.isPrepareDone = true;
					});
				}
			);
		}
    }
}

/// 挑战卡片选择Widget
Widget _createChallengeWidget({ContainerTestState state}) {
	
	int selectedIndex = 0;
	
	// 卡片宽度根据手机屏幕来计算
	MediaQueryData mediaQueryData = MediaQueryData.fromWindow(window);
	double cardWidth = mediaQueryData.size.width * 0.75;
	
	return Column(
		mainAxisAlignment: MainAxisAlignment.spaceBetween,
		children: <Widget>[
			Column(
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Container(
						margin: EdgeInsets.only(top: 30.0),
						child: _createChallengeTitle()
					),
					Container(
						height: cardWidth + 30,
						margin: EdgeInsets.only(top: 40.0),
						child: ChallengeSwiper(
							itemCount: state.challengeItems.length,
							itemSize: cardWidth,
							onIndexChanged: (int index) {
								selectedIndex = index;
							},
							itemBuilder: (int index) {
								return state.challengeItems[index];
							},
						)
					),
				],
			),
			Container(
				margin: EdgeInsets.fromLTRB(38, 0, 38, 30),
				height: 55,
				decoration: BoxDecoration(
					borderRadius: BorderRadius.all(Radius.circular(27.5)),
					color: Colors.deepOrange
				),
				child: _createChooseButton(
					onTap: () {
						print("choose button tap, $selectedIndex");
					}
				)
			),
		],
	);
}

Widget _createChallengeTitle() {
    return Text(
        "Choose one of the\ntopics to challenge",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
    );
}

Widget _createChooseButton({GestureTapCallback onTap}) {
    
    return GestureDetector(
        onTap: onTap,
        child: Container(
            color: Color.fromARGB(0, 0, 0, 0),
            alignment: Alignment.center,
                child: Text(
                    "Choose",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                ),
        ),
    );
}
