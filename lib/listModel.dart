import 'package:flutter/material.dart';

import 'task.dart';
import 'taskRow.dart';

class ListModel {
  ListModel(this.listKey, items) : this.items = new List.of(items);

  final GlobalKey<AnimatedListState> listKey; //GlobalKey能够跨Widget访问状态
  final List<Task> items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, Task item) {
    items.insert(index, item);
    _animatedList.insertItem(index,
        duration: new Duration(milliseconds: 450)); //动画出现延迟的时间
  }

  Task removeAt(int index) {
    final Task removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
          index,
          (context, animation) => new TaskRow(
                task: removedItem,
                animation: animation,
              ),
          duration: new Duration(
              milliseconds: (450 + 150 * (index / length)).toInt()));
    }
    return removedItem;
  }

  int get length => items.length;

  Task operator [](int index) => items[index];

  int indexOf(Task item) => items.indexOf(item);
}