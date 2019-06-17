import 'package:flutter/material.dart';

//切割图片(曲线形)
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // 线到（`lineTo`）方法，添加从当前点到给定点的直线段。
    // 起点变量。
    path.lineTo(0.0, size.height - 35.0);
    // 偏移（`Offset`）类，不可变的2D浮点偏移量。
    // 第一个控制点和第一点变量。
    var firstControlPoint = Offset(size.width / 4, size.height - 85.0);
    var firstPoint = Offset(size.width / 2, size.height - 45.0);
    // 二次贝塞尔曲（`quadraticBezierTo`）方法，
    // 使用控制点（x1，y1）添加从当前点到给定点（x2，y2）的二次贝塞尔曲线段。
    // 第一个中间曲线变量。
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);
    // 第二个控制点和第二点变量。
    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    // 第二个中间曲线变量。
    var secondPoint = Offset(size.width, size.height - 15.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);
    path.lineTo(size.width, size.height);
    // 终点变量。
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}