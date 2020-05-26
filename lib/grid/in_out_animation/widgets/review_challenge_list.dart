
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/tools/ui_screen.dart';

/// 用户逼单，Review界面中的挑战卡片列表
///
/// 展示效果：
/// 1，从下网上冒出
/// 2，多个挑战时，可能遮挡ReviewAvatarList控件
class ReviewChallengeList extends StatefulWidget {
  
  ReviewChallengeList({
    Key key
  }) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return ReviewChallengeListState();
  }
}

class ReviewChallengeListState extends State<ReviewChallengeList> {
  
  /// AnimatedList的Key
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey<AnimatedListState>();
  
  /// AnimatedListState
  AnimatedListState get _animatedList => _animatedListKey.currentState;
  
  /// 数据源
  List<ReviewChallengeModel> _listData;

  /// 动画时间
  Duration duration;
  
  @override
  void initState() {
    super.initState();
    _listData = [];
    duration = const Duration(milliseconds: 600);
  }
  
  @override
  Widget build(BuildContext context) {
  
    Widget child = AnimatedList(
      key: _animatedListKey,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      reverse: true,
      initialItemCount: _listData.length,
      itemBuilder: _buildItem,
    );
    
    return child;
  }

  /// 新增头部数据
  void insert(ReviewChallengeModel model) {
    _listData.insert(0, model);
    _animatedList.insertItem(0, duration: duration);
  }

  /// 移除头部数据
  ReviewChallengeModel remove() {
  
    if (_listData.length == 0) {
      return null;
    }

    ReviewChallengeModel removedItem = _listData.removeAt(0);
    _animatedList.removeItem(0, (BuildContext context, Animation<double> animation) {
      return _buildRemovedItem(removedItem, context, animation);
    }, duration: duration);
  
    if (mounted) {
      setState(() {});
    }
  
    return removedItem;
  }

  /// 创建Item
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return ReviewChallengeCard(
      animation: animation,
      model: _listData[index],
    );
  }

  /// 创建移除动画专用的Item
  Widget _buildRemovedItem(ReviewChallengeModel model, BuildContext context, Animation<double> animation) {
    return ReviewChallengeCard(
      animation: animation,
      model: model,
    );
  }
}

/// 挑战卡片Model
class ReviewChallengeModel {
  
  /// 用户ID
  final String id;
  
  /// 用户性别
  final int gender;
  
  /// 用户名
  final String name;

  ReviewChallengeModel({
    this.id,
    this.gender,
    this.name,
  });
}

/// 挑战卡片Item
///
/// 内容元素：园切头像、sayHi文案、Reply按钮
class ReviewChallengeCard extends StatelessWidget {
  
  /// 容器内元素的边距
  static double margin = dp(15);

  /// 动画值
  final Animation<double> animation;
  
  /// 数据
  final ReviewChallengeModel model;
  
  /// 点击回调
  final VoidCallback replyOnTap;

  ReviewChallengeCard({
    this.animation,
    this.model,
    this.replyOnTap
  });
  
  @override
  Widget build(BuildContext context) {
    
    return ChallengeCardTransition(
      animation: animation,
      child: Container(
        child: Container(
          margin: EdgeInsets.all(dp(10)),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0x55999999),
                    offset: Offset(0, 2),
                    blurRadius: 3
                )
              ]
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 头像
              _createAvatar(model.id),
              // Column：文案+按钮
              Expanded(
                child: _createTextAndButton(_sayHiWording(), replyOnTap),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  String _sayHiWording () {
    return "${model.name} sent you a message";
  }
  
  /// 构建头像，附带定死的小红点
  Widget _createAvatar(String imagePath) {
  
    double size = dp(58);
    return Container(
        margin: EdgeInsets.only(top: margin, left: margin),
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size/2))
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            ClipOval(
              // TODO 待替换成图片
              child: Container(
                color: Colors.green,
              ),
            ),
            Positioned(
              right: dp(-5),
              child: Container(
                width: dp(18),
                height: dp(18),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(dp(9))),
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    )
                ),
                child: Text(
                  "1",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: dp(11)
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
  
  /// 构建文案+Reply按钮
  Widget _createTextAndButton(String text, VoidCallback onTap) {
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: dp(20), right: dp(15), top: dp(15), bottom: dp(10)),
          child: Text(
            text ?? "",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: dp(16)
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: dp(15), right: dp(15)),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: dp(82),
                height: dp(33),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.all(Radius.circular(dp(16.5)))
                ),
                child: Text(
                  "Reply",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: dp(16)
                  ),
                ),
              ),
            )
        )
      ],
    );
  }
}

/// 挑战Card动画
///
/// 效果：位移+透明度
class ChallengeCardTransition extends AnimatedWidget {
  
  /// 位移动画曲线
  static const Cubic curve = Curves.easeInOut;
  
  /// 动画时间值监听
  Animation<double> get animationFactor => listenable as Animation<double>;
  
  /// 被做动画的控件
  final Widget child;
  
  const ChallengeCardTransition({
    Key key,
    @required Animation<double> animation,
    this.child
  }) :
        assert(animation != null),
        super(key: key, listenable: animation);
  
  @override
  Widget build(BuildContext context) {
    
    double value = curve.transformInternal(animationFactor.value);
    return Align(
      alignment: Alignment.center,
      heightFactor: value,
      widthFactor: value,
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }
}