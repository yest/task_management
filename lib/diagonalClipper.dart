import 'package:flutter/material.dart';

//切割图片(三角形)
class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 60.0); //首先移到启示切割点
    path.lineTo(size.width, size.height); //切割进过点
    path.lineTo(size.width, 0.0); //切割终点

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}