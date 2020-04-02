import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/container_test/widgets/challenge_prepare.dart';
import 'package:my_flutter/grid/container_test/widgets/challenge_select.dart';
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
	
	ChallengeSelect challengeSelect;
    
    @override
    Widget build(BuildContext context) {
	
		challengeSelect = ChallengeSelect(challengeItems: widget.state.challengeItems);
    	
    	List<Widget> widgets = [];
    	widgets.add(Container(
			child: challengeSelect
		));
    	
    	// 场景动画逻辑
        // 1，prepare执行加载动画
        // 2，prepare结束回调，清理掉prepare，在不重新渲染select的情况下，通知select开始执行动画
    	if (!widget.isPrepareDone) {
    		widgets.add(Container(
				color: Color.fromARGB(255, 248, 248, 248),
				child: ChallengePrepare(loadingDoneCallback: () {
					setState(() {
						widget.isPrepareDone = true;
						challengeSelect.startAnimation();
					});
				})
			));
		}
    	
    	// 之所以这里用Stack，是为了让select预先就加载好，prepare初始化只是覆盖在其上面
        // 这么做的原因，是因为flutter_swiper这个第三方UI如果即时渲染加载，会出现一个跳动的问题
    	return Stack(children: widgets);
    }
}
