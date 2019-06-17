import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'addTask.dart';
import 'mainPage.dart' as mp;

typedef void MyCallback(int x);

//为粉色悬浮button添加动画_1
class AnimatedFab extends StatefulWidget {
  //final VoidCallback onClick;

  //const AnimatedFab({Key key, this.onClick}) : super(key: key);

  final String email;
  final MyCallback callbackFunction;
  AnimatedFab({this.email, this.callbackFunction});

  @override
  _AnimatedFabState createState() => new _AnimatedFabState();
}

//为粉色悬浮button添加动画_2  改色，改图表
class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController; //动画控制器
  Animation<Color> _colorAnimation;
  //确定按钮增大的范围
  final double expandedSize = 180.0;
  final double hiddenSize = 20.0;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //增大按钮 设置小按钮图表
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: expandedSize,
      height: expandedSize,
      child: new AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildExpandedBackground(),
              _buildOption(Icons.info_outline, 0.0, 2),
              _buildOption(Icons.add_circle_outline, -math.pi / 2, 1),
              //_buildOption(Icons.access_time, -2 * math.pi / 3),
              _buildOption(Icons.copyright, math.pi, 3),
              _buildFabCore(),
            ],
          );
        },
      ),
    );
  }

  //扩展按钮边缘后的小按钮
  Widget _buildOption(IconData icon, double angle, int action) {
    double iconSize = 0.0;
    if (_animationController.value > 0.8) {
      iconSize = 26.0 * (_animationController.value - 0.8) * 5;
    }
    return new Transform.rotate(
      angle: angle,
      child: new Align(
        alignment: Alignment.topCenter,
        child: new Padding(
          padding: new EdgeInsets.only(top: 8.0),
          child: new IconButton(
            onPressed: () {buttonClick(action);},
            icon: new Transform.rotate(
              angle: -angle,
              child: new Icon(
                icon,
                color: Colors.white,
              ),
            ),
            iconSize: iconSize,
            alignment: Alignment.center,
            padding: new EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }

  void buttonClick(int action) {
    widget.callbackFunction(action);
    /*if(action == 1) {
     /* Navigator.of(context).push(
            new MaterialPageRoute(
                builder: (BuildContext context) => new AddTask(
                      email: widget.email,
                    )),
          );*/
        widget.callbackFunction(1);
    } else if(action == 2) {
      //mp.MainPage().showCompleted();
      //mp.MainPage mainPage = new mp.MainPage();
      //mainPage.
      widget.callbackFunction(2);
    }*/
    close();
  }

  void _onIconClick(String action) {
    //widget.onClick();
    print("Clicked");
    close();
  }

  //增加按钮边界的方法
  Widget _buildExpandedBackground() {
    double size =
        hiddenSize + (expandedSize - hiddenSize) * _animationController.value;
    return new Container(
      height: size,
      width: size,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    );
  }

  //用于改色和改图表
  Widget _buildFabCore() {
    double scaleFactor = 2 * (_animationController.value - 0.5).abs();
    return new FloatingActionButton(
      onPressed: _onFabTap,
      child: new Transform(
        alignment: Alignment.center,
        transform: new Matrix4.identity()..scale(1.0, scaleFactor),
        child: new Icon(
          _animationController.value > 0.5 ? Icons.close : Icons.filter_list,
          color: Colors.white,
          size: 26.0,
        ),
      ),
      backgroundColor: _colorAnimation.value,
    );
  }

  open() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }

  close() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  _onFabTap() {
    if (_animationController.isDismissed) {
      open();
    } else {
      close();
    }
  }
}