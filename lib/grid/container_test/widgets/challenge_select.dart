
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:my_flutter/grid/container_test/widgets/challenge_swiper.dart';

class ChallengeSelect extends StatefulWidget {
    
    /// 卡片数据源
    final List<ChallengeSwiperItem> challengeItems;
    
    /// Choose点击事件
    final Function(int) chooseTapped;

    /// state对象
    _ChallengeSelectState state;

    ChallengeSelect({
        Key key,
        @required this.challengeItems,
        this.chooseTapped,
    }): assert(challengeItems != null, "[ChallengeSelect] challengeItems can't be null"),
        super(key: key);
    
    startAnimation() {
        state.startAnimation();
    }
    
    @override
    State<StatefulWidget> createState() {
        
        state = _ChallengeSelectState();
        return state;
    }
}

class _ChallengeSelectState extends State<ChallengeSelect> with TickerProviderStateMixin {
    
    AnimationController animationController;
    Animation<double> fadeAnimation;
    Animation<double> fadeBarAnimation;
    
    @override
    void initState() {
    
        super.initState();
        
        animationController = AnimationController(duration: Duration(milliseconds:1200), vsync: this);
        CurvedAnimation curve = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
        fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(curve);
        fadeBarAnimation = Tween(begin: 1.0, end: 0.0).animate(curve);
    }
    
    @override
    void dispose() {
        animationController.dispose();
        super.dispose();
    }
    
    @override
    Widget build(BuildContext context) {
    
        int selectedIndex = 0;
    
        // 卡片宽度根据手机屏幕来计算
        MediaQueryData mediaQueryData = MediaQueryData.fromWindow(window);
        double cardWidth = mediaQueryData.size.width * 0.75;
    
        return Stack(
            children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(top: 30.0),
                                    child: _createChallengeTitle(animation: fadeAnimation)
                                ),
                                Container(
                                    height: cardWidth + 30,
                                    margin: EdgeInsets.only(top: 40.0),
                                    child: ChallengeSwiper(
                                        itemCount: widget.challengeItems.length,
                                        itemSize: cardWidth,
                                        onIndexChanged: (int index) {
                                            selectedIndex = index;
                                        },
                                        itemBuilder: (int index) {
                                            return widget.challengeItems[index];
                                        },
                                    )
                                ),
                            ],
                        ),
                        _createChooseButton(animation: fadeAnimation, onTap: () {
                            print("Choose按钮点击,$selectedIndex");
                        }),
                    ],
                ),
                _createMaskBar(animation: fadeBarAnimation)
            ],
        );
    }
    
    startAnimation() {
        animationController.forward();
    }
}


Widget _createChallengeTitle({Animation animation}) {
    return FadeTransition(
        opacity: animation,
        child: Text(
            "Choose one of the\ntopics to challenge",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
        ),
    );
}

Widget _createChooseButton({Animation animation, GestureTapCallback onTap}) {
    
    return FadeTransition(
        opacity: animation,
        child: Container(
            margin: EdgeInsets.fromLTRB(38, 0, 38, 30),
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(27.5)),
                color: Colors.deepOrange
            ),
            child: GestureDetector(
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
                    )
                ),
            )
        ),
    );
}

Widget _createMaskBar({Animation animation}) {
    
    Color color = Color.fromARGB(255, 248, 248, 248);
    
    return Positioned(
        top: 0,
        right: 0,
        bottom: 100,
        width: 50,
        child: FadeTransition(
            opacity: animation,
            child: Container(
                color: color,
            ),
        )
    );
}