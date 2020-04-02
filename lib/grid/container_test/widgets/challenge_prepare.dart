
import "dart:ui";
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flare_flutter/flare_actor.dart';

class ChallengePrepare extends StatefulWidget  {
    
    /// Flare动画结束回调
    final Function() loadingDoneCallback;
    
    ChallengePrepare({
       this.loadingDoneCallback
    });
    
    @override
    State<StatefulWidget> createState() => _ChallengePrepareState();
}

class _ChallengePrepareState extends State<ChallengePrepare> with TickerProviderStateMixin {
    
    // 卡片大小
    double cardSize;
    
    AnimationController fadeController;
    Animation<double> fadeAnimation;
    
    @override
    void initState() {
        
        super.initState();
        
        MediaQueryData mediaQueryData = MediaQueryData.fromWindow(window);
        cardSize = mediaQueryData.size.width * 0.75;
        
        fadeController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
        fadeController.addStatusListener((AnimationStatus status) {
            print(status);
        });
        
        CurvedAnimation curve = CurvedAnimation(parent: fadeController, curve:  Curves.easeInOut);
        fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(curve);
    }
 
    @override
    void dispose() {
        fadeController.dispose();
        super.dispose();
    }
    
    @override
    Widget build(BuildContext context) {
        
        return Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
                Positioned(
                    top: 140,
                    child: FadeTransition(
                        opacity: fadeAnimation,
                        child: Center(
                            child: Text(
                                "Preparing for your challenge",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                ),
                            ),
                        ),
                    ),
                ),
                Positioned(
                    top: 90,
                    height: cardSize + 50,
                    child: FlareActor(
                        "asset/flare/WooPlusWhenIthemeLoading.flr",
                        animation: "Untitled",
                        alignment: Alignment.topCenter,
                        sizeFromArtboard: true,
                        callback: (String name) {
                            widget.loadingDoneCallback();
                            fadeController.forward();
                        },
                    ),
                )
            ],
        );
    }
}