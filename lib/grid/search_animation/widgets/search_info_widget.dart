
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/shift_opacity_transition.dart';
import 'package:my_flutter/tools/ui_screen.dart';

class SearchInfoWidget extends StatefulWidget {
  
  /// 有多少人在附近
  final int peoples;
  
  /// 原价
  final double originPrice;
  
  /// 折扣价
  final double discountPrice;
  
  /// 购买点击回调
  final VoidCallback onTap;

  SearchInfoWidget({
    Key key,
    this.peoples,
    this.originPrice = 0,
    this.discountPrice = 0,
    this.onTap
  }) : super(key: key);
 
  @override
  State<StatefulWidget> createState() {
    return SearchInfoWidgetState();
  }
}

class SearchInfoWidgetState
    extends State<SearchInfoWidget> with TickerProviderStateMixin {
  
  /// 文案的左边距
  static double _textLeftMargin = dp(45);
  
  /// 按钮的左右边距
  static double _buttonLRMargin = dp(45);
  
  /// People动画控制器
  AnimationController _peopleController;
  /// People动画
  Animation<double> _peopleAnimation;
  
  /// Price动画控制器
  AnimationController _priceController;
  /// Price动画
  Animation<double> _priceAnimation;
  
  /// PriceDesc动画控制器
  AnimationController _priceDescController;
  /// PriceDesc动画
  Animation<double> _priceDescAnimation;
  
  /// 按钮动画控制器
  AnimationController _buttonController;
  /// 按钮动画
  Animation<double> _buttonAnimation;
  
  @override
  void initState() {
    super.initState();
    _initAnimation();
  }
  
  @override
  void dispose() {
    
    _peopleController.dispose();
    _priceController.dispose();
    _priceDescController.dispose();
    _buttonController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              //alignment: Alignment.center,
              margin: EdgeInsets.only(top: dp(20)),
              child: Column(
                children: <Widget>[
                  // 有多少人在你周围
                  _createPeopleAroundText(widget.peoples),
                  // 价格
                  _createPriceText(widget.originPrice, widget.discountPrice),
                  // 价格描述
                  _createPriceDesc(widget.originPrice, widget.discountPrice),
                ],
              ),
            ),
          ),
          // 底部按钮
          _createButton("Start Dating Now!", widget.onTap)
        ],
      ),
    );
  }
  
  /// 开始动画
  ///
  /// 各组件做不同上移+透明度动画
  void startAnimation() {
  
    _peopleController.forward();
    Future.delayed(Duration(milliseconds: 200), () {
      _priceController.forward();
    });
    Future.delayed(Duration(milliseconds: 400), () {
      _priceDescController.forward();
    });
    Future.delayed(Duration(milliseconds: 600), () {
      _buttonController.forward();
    });
  }
  
  /// 动画设置 - 初始化
  void _initAnimation() {
    
    Duration duration = const Duration(milliseconds: 1000);
  
    // --------------- People动画 ---------------
    _peopleController = AnimationController(
        duration: duration,
        vsync: this
    );
    
    CurvedAnimation peopleCurve = CurvedAnimation(
        parent: _peopleController,
        curve: Curves.easeInOut
    );
    
    _peopleAnimation = Tween(begin: 0.0, end: 1.0).animate(peopleCurve);
    
    // --------------- Price动画 ---------------
    _priceController = AnimationController(
      duration: duration,
      vsync: this
    );
    
    CurvedAnimation priceCurve = CurvedAnimation(
      parent: _priceController,
      curve: Curves.easeInOut
    );
    
    _priceAnimation = Tween(begin: 0.0, end: 1.0).animate(priceCurve);

    // --------------- PriceDesc动画 ---------------
    _priceDescController = AnimationController(
        duration: duration,
        vsync: this
    );

    CurvedAnimation priceDescCurve = CurvedAnimation(
        parent: _priceDescController,
        curve: Curves.easeInOut
    );

    _priceDescAnimation = Tween(begin: 0.0, end: 1.0).animate(priceDescCurve);

    // --------------- PriceDesc动画 ---------------
    _buttonController = AnimationController(
        duration: duration,
        vsync: this
    );

    CurvedAnimation buttonCurve = CurvedAnimation(
        parent: _priceDescController,
        curve: Curves.easeInOut
    );

    _buttonAnimation = Tween(begin: 0.0, end: 1.0).animate(buttonCurve);
  }
  
  /// 创建你周围有XXX人文案
  Widget _createPeopleAroundText(int num) {
    
    return ShiftOpacityTransition(
      animation: _peopleAnimation,
      insetsMaker: (double value) {
        return EdgeInsets.only(top:dp(20) + dp(30) * (1 - value), left: _textLeftMargin);
      },
      child: Text(
        "There are $num women\naround meet your criteria",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xffffffff),
            fontSize: dp(24)),
      ),
    );
  }
  
  /// 创建折扣价格文案
  Widget _createPriceText(double origin, double discount) {
  
    TextStyle priceStyle = TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xffffffff),
        fontSize: dp(40)
    );
    
    int percent = ((1.0 - discount / origin) * 100.0).toInt();
    return ShiftOpacityTransition(
      animation: _priceAnimation,
      insetsMaker: (double value) {
        return EdgeInsets.only(top: dp(5) + dp(20) * (1 - value), left: _textLeftMargin);
      },
      child: RichText(
        text: TextSpan(
            children: [
              TextSpan(
                  text: "$percent% OFF\n",
                  style: priceStyle.apply(color: Colors.deepOrange)
              ),
              TextSpan(
                text: "Only \$$discount\n",
                style: priceStyle,
              ),
              TextSpan(
                  text: "\$$origin\n",
                  style: priceStyle.apply(decoration: TextDecoration.lineThrough)
              )
            ]
        ),
      ),
    );
  }
  
  /// 创建价格描述文案
  Widget _createPriceDesc(double origin, double discount) {
    
    return ShiftOpacityTransition(
      animation: _priceDescAnimation,
      insetsMaker: (double value) {
        return EdgeInsets.only(top: dp(5) + dp(10) * (1 - value), left: _textLeftMargin);
      },
      child: Text(
        "\$$discount for the first moneth, then \$$origin per month",
        style: TextStyle(
            color: Color(0xffffffff),
            fontSize: dp(12)
        ),
      ),
    );
  }
  
  /// 创建按钮
  Widget _createButton(String text, VoidCallback onTap) {
    
    return ShiftOpacityTransition(
        animation: _buttonAnimation,
        insetsMaker: (double value) {
          return EdgeInsets.only(bottom: dp(20) * value);
        },
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: dp(55),
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: _buttonLRMargin, right: _buttonLRMargin),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.all(Radius.circular(dp(55) / 2.0)),
            ),
            child: Text(
              text ?? "",
              style: TextStyle(
                color: Colors.white,
                fontSize: dp(14),
              ),
            ),
          ),
        ),
    );
  }
}