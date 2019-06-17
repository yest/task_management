import 'task.dart';
import 'package:flutter/material.dart';

//每个TASK行的显示
class TaskRow extends StatelessWidget {
  final Task task;
  final Animation<double> animation;
  final double dotSize = 12.0;

  const TaskRow({Key key, this.task, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      //设置淡入淡出效果
      opacity: animation,
      child: new SizeTransition(
        sizeFactor: animation,
        child: new Row(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(horizontal: 32.0 - dotSize),
              child: new Container(
                //增加空格间隙  height: dotSize
                height: dotSize * 6,
                width: dotSize,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle, color: task.color),
              ),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    task.name,
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  new Text(
                    task.category,
                    //style: new TextStyle(fontSize: 12.0, color: task.color),
                    style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                  )
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: new Text(
                task.time,
                style: new TextStyle(fontSize: 14.0, color: task.color),
                //style: new TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
  /*
  @override
  State<StatelessWidget> createState() {
    return new TaskRowState();
  }
  */
}