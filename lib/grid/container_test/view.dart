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
    	
    	return Stack(children: widgets);
    }
}
