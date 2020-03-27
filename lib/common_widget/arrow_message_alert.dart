
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArrowMessageAlert {

  static show (BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder:(context) => _ArrowMessageAlert()
    );
  }
}

class _ArrowMessageAlert extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        height: 40,
        width: 40,
        child: Text(
          "测试文本",
          style: TextStyle(fontSize: 22, color: Colors.lightBlue),

        ),
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(
          color: Colors.red
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20)
        )
      ),
    );
  }
}