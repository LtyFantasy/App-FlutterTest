
import 'package:flutter/widgets.dart';

class GridModel {

  String name;
  Function(BuildContext context, Object argument) event;

  GridModel({this.name, this.event});
}