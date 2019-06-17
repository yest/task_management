import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'curveClipper.dart';

class AddTask extends StatefulWidget {
  AddTask({this.email});
  final String email;

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _dueDate = new DateTime.now();
  String _dateText = '';

  String newTask = '';
  String note = '';
  bool completed = false;

  double _imageHeight = 256.0;

  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2029));

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _addData() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('task');
      await reference.add({
        "email": widget.email,
        "title": newTask,
        "duedate": _dueDate,
        "note": note,
        "completed": completed
      });
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateText = "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";
  }

  Widget _buildImage() {
    return new ClipPath(
      //剪切图片右下角
      clipper: new CurveClipper(), // define the method to clip image
      child: new Image.asset(
        'img/bg_pink.jpg',
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver, //图片混色
        color: new Color.fromARGB(30, 20, 10, 40), //混色模式定义
      ),
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 18.0, vertical: 32.0), //；类似于盒子的东西
      child: new Row(
        //横向子布局
        children: <Widget>[
          new Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(6.0),
              image: DecorationImage(
                image: AssetImage("img/logo_1_2.jpg"),
              ),
            ),
          ),
          //new Icon(Icons.account_box, size: 32.0, color: Colors.white),
          new Expanded(
            //灵活布局
            child: new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text(
                "Simple Task",
                style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: "Pacifico"),
                    //fontWeight: FontWeight.w600),
              ),
            ),
          ),
          //new Icon(Icons.linear_scale, color: Colors.white),
          
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return new Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.add_box,
              color: Colors.white,
              size: 40.0,
            ),
          ),
          Text(
            "ADD TASK",
            style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                _buildImage(),
                _buildTopHeader(),
                _buildHeader(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (String str) {
                setState(() {
                  newTask = str;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.dashboard),
                  hintText: "New Task",
                  border: InputBorder.none),
              style: TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range),
                ),
                Expanded(
                    child: Text(
                  "Due date",
                  style: new TextStyle(fontSize: 22.0, color: Colors.black54),
                )),
                FlatButton(
                    onPressed: () => _selectDueDate(context),
                    child: Text(
                      _dateText,
                      style:
                          new TextStyle(fontSize: 22.0, color: Colors.black54),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (String str) {
                setState(() {
                  note = str;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.note),
                  hintText: "Note",
                  border: InputBorder.none),
              style: TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 40,
                  ),
                  onPressed: () {
                    _addData();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
