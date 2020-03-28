
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ArrowMessageAlertCallback = void Function();

class ArrowMessageAlert {

    static show (BuildContext context, String text, {ArrowMessageAlertCallback callback}) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder:(context) => _ArrowMessageAlert(text: text, callback: callback)
        );
    }
}

class _ArrowMessageAlert extends StatelessWidget {
    
    final String text;
    final ArrowMessageAlertCallback callback;

    _ArrowMessageAlert({this.text, this.callback});
    
    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                            text ?? "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.none
                            ),
                        ),
                    ),
                    Row(
                        children: <Widget>[
                            Expanded(
                                child: Container(),
                            ),
                            Container(
                                width: 65.0,
                                height: 33.0,
                                child: Center(
                                    child: GestureDetector(
                                        child: Text(
                                            "OK",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                decoration: TextDecoration.none
                                            ),
                                        ),
                                        onTap: callback
                                    ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.5)
                                    ),
                                ),
                            ),
                        ],
                    )
                ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)
                )
            ),
        );
    }
}