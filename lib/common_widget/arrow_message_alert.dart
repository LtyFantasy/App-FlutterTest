
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ArrowMessageAlertCallback = void Function();

/// 带箭头的对话提示框
///
/// Author: Loki
/// Date: 2020/03/29
class ArrowMessageAlert {

    /// 显示
    ///
    /// 参数: [context]上下文
    /// 参数: [text]为需要显示的文本，不能为null
    /// 参数: [startPoint]为对话框箭头需要指向的位置，注意，因为边距的存在，不一定真能完美指向
    /// 参数: 可选，[callback]点击按钮后的回调事件
    static show ({
        @required BuildContext context,
        @required String text,
        @required Offset startPoint,
        ArrowMessageAlertCallback callback}) {
        
        assert(context != null, "[ArrowMessageAlert] 未获取到context");
        assert(text != null, "[ArrowMessageAlert] text不能为空]");
        assert(startPoint != null, "[ArrowMessageAlert] startPoint不能为空");
        
        showDialog(
            context: context,
            barrierDismissible: false,
            builder:(context) => _ArrowMessageAlert(
                text: text,
                startPoint: startPoint,
                callback: callback
            )
        );
    }
}

/// 对话框控件
class _ArrowMessageAlert extends StatelessWidget {
    
    final String text;
    final Offset startPoint;
    final ArrowMessageAlertCallback callback;
    
    // 对话框上的箭头
    static const double arrowWidth = 30.0;
    static const double arrowHeight = 15.0;

    // 对话框
    static const double lrMargin = 12.0;
    static const double padding = 20.0;
    static const double maxWidth = 305.0;
    static const double minWidth = 200.0;
    static const double containerCornerRadius = 10.0;

    _ArrowMessageAlert({this.text, this.startPoint, this.callback});
    
    @override
    Widget build(BuildContext context) {
    
        TextStyle style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
        final TextPainter textPainter = TextPainter(
            text: TextSpan(text: text, style: style),
            maxLines: 1,
            textDirection: TextDirection.ltr)
            ..layout(minWidth: 0, maxWidth: double.infinity);

        // 容器宽度计算
        double containerWidth = textPainter.size.width + padding*2;
        if (containerWidth > maxWidth) {
            containerWidth = maxWidth;
        }
        else if (containerWidth < minWidth) {
            containerWidth = minWidth;
        }
        
        return Container(
            alignment: Alignment.topLeft,
            child: Stack(
                children: <Widget>[
                    _createPositioned(
                        containerWidth: containerWidth,
                        startPoint: startPoint,
                        child: Container(
                            constraints: BoxConstraints(
                                maxWidth: maxWidth,
                                minWidth: minWidth,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(containerCornerRadius)
                                )
                            ),
                            padding: EdgeInsets.all(padding),
                            child: _createDialogContainer(
                                context: context,
                                containerWidth: containerWidth,
                                text: text,
                                callback: callback
                            ),
                        ),
                    ),
                ],
            )
        );
    }
    
    /// 创建偏移容器，适应对应的点击位置
    /// 如果在屏幕的上半部分，箭头朝上
    /// 如果在屏幕的下半部分，箭头朝下
    /// 箭头尽可能的指向点击位置，但是因为左右边距的限制，最左或者最右可能无法完美指向
    Positioned _createPositioned ({@required double containerWidth, @required Offset startPoint, @required Widget child}) {
    
        final MediaQueryData mediaQueryData = MediaQueryData.fromWindow(window);
        final double width = mediaQueryData.size.width - lrMargin*2;
        final double height = mediaQueryData.size.height;
        final double safeTop = mediaQueryData.padding.top;
        final double safeBottom = mediaQueryData.padding.bottom;
        
        // 容器偏移量计算
        Offset containerOffset;
        if (startPoint.dx < lrMargin + containerWidth / 2) {
            containerOffset = Offset(lrMargin, startPoint.dy);
        }
        else if (startPoint.dx > width - (lrMargin + containerWidth / 2)) {
            containerOffset = Offset(width - containerWidth + lrMargin, startPoint.dy);
        }
        else {
            containerOffset = Offset(startPoint.dx - containerWidth / 2, startPoint.dy);
        }

        // 箭头水平偏移量计算
        // 注意，箭头的偏移量是建立在容器已经偏移的基础之上的
        double arrowDx = startPoint.dx - containerOffset.dx - arrowWidth / 2;
        if (arrowDx < lrMargin + containerCornerRadius) {
            arrowDx = lrMargin + containerCornerRadius;
        }
        else if (arrowDx > width - lrMargin - containerCornerRadius - containerOffset.dx - arrowWidth/2) {
            arrowDx = width - lrMargin - containerCornerRadius - containerOffset.dx - arrowWidth/2;
        }
        
        List<Widget> widgets = [child];
        Positioned positioned;
        
        // 箭头朝上
        if (startPoint.dy < height / 2) {
            
            Widget arrowWidget =  Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: arrowDx),
                child: CustomPaint(
                    size: Size(arrowWidth, arrowHeight),
                    painter: _ArrowPainter(down: false),
                ),
            );
            
            widgets.insert(0, arrowWidget);
            positioned = Positioned(
                top: containerOffset.dy - safeTop,
                left: containerOffset.dx,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widgets
                ),
            );
        }
        // 箭头朝下
        else {
    
            Widget arrowWidget =  Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: arrowDx),
                child: CustomPaint(
                    size: Size(arrowWidth, arrowHeight),
                    painter: _ArrowPainter(down: true),
                ),
            );
            
            widgets.add(arrowWidget);
            positioned = Positioned(
                bottom: height - containerOffset.dy - safeBottom,
                left: containerOffset.dx,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widgets
                ),
            );
        }
        return positioned;
    }
    
    /// 创建对话框
    Widget _createDialogContainer({
        @required BuildContext context,
        @required double containerWidth,
        @required String text,
        @required ArrowMessageAlertCallback callback}) {
        
        final double buttonWidth = 65.0;
        final leftPadding = containerWidth - buttonWidth - (padding*2);
        
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                // 文本容器
                Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                        ),
                    ),
                ),
                // 按钮容器
                Container(
                    padding: EdgeInsets.only(left: leftPadding),
                    child:GestureDetector(
                        child: Container(
                            width: 65.0,
                            height: 33.0,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(16.5)
                                ),
                            ),
                            child: Center(
                                child: Text(
                                    "OK",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        decoration: TextDecoration.none
                                    ),
                                ),
                            ),
                        ),
                        onTap: (){
                            Navigator.of(context).pop();
                            callback();
                        }
                    ),
                )
            ],
        );
    }
}

/// 对话框中的三角箭头
class _ArrowPainter extends CustomPainter {
    
    final bool down;
    _ArrowPainter({this.down});
    
    @override
    void paint(Canvas canvas, Size size) {
        
        // 绘制三角形
        Path path = Path();
        if (down) {
            path.moveTo(0, 0);
            path.lineTo(size.width, 0);
            path.lineTo(size.width/2, size.height);
            path.lineTo(0, 0);
        }
        else {
            path.moveTo(0, size.height);
            path.lineTo(size.width / 2, 0);
            path.lineTo(size.width, size.height);
            path.lineTo(0, size.height);
        }
        
        Paint paint = Paint()
            ..style = PaintingStyle.fill
            ..color = Colors.white;
        canvas.drawPath(path, paint);
    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
        return false;
    }
}