import 'package:flutter/material.dart';

//用于设置TASK的类: 建立接收对象类
class Task {
  final String name;
  final String category;
  final String time;
  final Color color;
  final bool completed;

  Task({this.name, this.category, this.time, this.color, this.completed});
}