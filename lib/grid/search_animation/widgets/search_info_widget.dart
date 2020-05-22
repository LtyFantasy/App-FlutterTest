
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/grid/search_animation/widgets/shift_opacity_transition.dart';

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
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    
    List<Widget> children = [];
    
    // 有多少人在你周围
    children.add(_createPeopleAroundText(widget.peoples));
    // 价格
    children.add(_createPriceText(widget.originPrice, widget.discountPrice));
    // 价格描述
    children.add(_createPriceDesc(14.99, 9.99));
    
    return Container(
      //height: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
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
  }
  
  /// 动画设置 - 初始化
  void _initAnimation() {
  
    // --------------- People动画 ---------------
    _peopleController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );
    
    CurvedAnimation peopleCurve = CurvedAnimation(
        parent: _peopleController,
        curve: Curves.easeInOut
    );
    
    _peopleAnimation = Tween(begin: 0.0, end: 1.0).animate(peopleCurve);
    
    // --------------- Price动画 ---------------
    _priceController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this
    );
    
    CurvedAnimation priceCurve = CurvedAnimation(
      parent: _priceController,
      curve: Curves.easeInOut
    );
    
    _priceAnimation = Tween(begin: 0.0, end: 1.0).animate(priceCurve);

    // --------------- PriceDesc动画 ---------------
    _priceDescController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );

    CurvedAnimation priceDescCurve = CurvedAnimation(
        parent: _priceDescController,
        curve: Curves.easeInOut
    );

    _priceDescAnimation = Tween(begin: 0.0, end: 1.0).animate(priceDescCurve);
  }
  
  /// 创建你周围有XXX人文案
  Widget _createPeopleAroundText(int num) {
    
    return ShiftOpacityTransition(
      animation: _peopleAnimation,
      insetsMaker: (double value) {
        return EdgeInsets.only(top:100 * (1 - value));
      },
      child: Text(
        "There are $num women\naround meet your criteria",
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xffffffff),
            fontSize: 24),
      ),
    );
  }
  
  /// 创建折扣价格文案
  Widget _createPriceText(double origin, double discount) {
  
    TextStyle priceStyle = const TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xffffffff),
        fontSize: 36
    );
    
    int percent = ((1.0 - discount / origin) * 100.0).toInt();
    return ShiftOpacityTransition(
      animation: _priceAnimation,
      insetsMaker: (double value) {
        return EdgeInsets.only(top: 5 + 100 * (1 - value));
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
        return EdgeInsets.only(top: 5 + 100 * (1 - value),);
      },
      child: Text(
        "\$$discount for the first moneth, then \$$origin per month",
        style: const TextStyle(
            color: Color(0xffffffff),
            fontSize: 12
        ),
      ),
    );
  }
}