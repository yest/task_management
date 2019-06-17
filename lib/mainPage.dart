import 'package:firebase/about.dart';
import 'package:firebase/info.dart';
import 'package:firebase/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart' as prefix0;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import 'addTask.dart';
import 'animatedFab.dart';
import 'curveClipper.dart';
import 'editTask.dart';
import 'dart:math' as math;

import 'initialList.dart';
import 'listModel.dart';
import 'taskRow.dart';
import 'task.dart';

typedef void MyCallback(int x);

//mainpage extend statefulWidget means it can change the state
class MainPage extends StatefulWidget {
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  MainPage({this.user, this.googleSignIn});

  //MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() =>
      new _MainPageState(); //if a class extend the StatefulWidget class, should override createState function
}

//加载主面板中的图片
class _MainPageState extends State<MainPage> {
  double _imageHeight = 256.0; //define how height of this image
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel listModel;
  bool showOnlyCompleted = false;

  void showCompleted(int x) {
    if (x == 1) {
      Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) => new AddTask(
                  email: widget.user.email,
                )),
      );
    } else if (x == 2) {
      Navigator.of(context).push(
        new MaterialPageRoute(builder: (BuildContext context) => new Info()),
      );
    } else if (x == 3) {
      Navigator.of(context).push(
        new MaterialPageRoute(builder: (BuildContext context) => new About()),
      );
    }
  }

  // sign out function
  void _signOut() {
    AlertDialog alertDialog = new AlertDialog(
      content: Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: new Image.network(widget.user.photoUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Sign out?",
                style: new TextStyle(fontSize: 16.0),
              ),
            ),
            new Divider(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    widget.googleSignIn.signOut();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePage()));
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.check),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      Text("Yes"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.close),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      Text("Cancel"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, tasks);
  }

  //overriding the build method is the most important part of this class,
  //thought this method the state will change
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //one kind of layout, we can add more elements like: appbar,floatingActionButton,body and so on.
      body: new Stack(
        //堆叠布局，like Framelayout in android, Stack is a container Widget, that places widgets on top of each other. defoult aligment:topstar
        children: <Widget>[
          _buildTimeline(), //时间线置于底层
          _buildImage(), //用户背景图
          _buildTopHeader(), //Simple Task
          _buildProfileRow(), //用户信息
          _buildBottomPart(), //My Task list
          _buildFab(), //悬浮按钮
        ],
      ),
    );
  }

  //加载背景图片
  Widget _buildImage() {
    return new ClipPath(
      //剪切图片右下角
      clipper: new CurveClipper(), // define the method to clip image
      child: new Image.asset(
        'img/main_background_7.jpg',
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver, //图片混色
        color: new Color.fromARGB(30, 20, 10, 40), //混色模式定义
      ),
    );
  }

  //加载头部文件
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
                    //fontWeight: FontWeight.bold,
                    fontFamily: "Pacifico"),
              ),
            ),
          ),
          //new Icon(Icons.linear_scale, color: Colors.white),
          new IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),
    );
  }

//加载用户头像
  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5), //用于定位
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            //圆形图片工具
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new NetworkImage(widget.user.photoUrl),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              // 列子布局
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  widget.user.displayName,
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//list 标签（任务标题）
  Widget _buildBottomPart() {
    //程序主体部分
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight - 40.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(false),
        ],
      ),
    );
  }

//TODO
  /*Widget _buildTasksList() {
    return new Expanded(
      child: new AnimatedList(
        initialItemCount: tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
    );
  }*/

  Widget _buildTasksList(bool completed) {
    if (completed) {
      //print("COMPLETED");
      return Expanded(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("task")
              .where("email", isEqualTo: widget.user.email)
              .where("completed", isEqualTo: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return new Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            return new TaskList(
              document: snapshot.data.documents,
            );
          },
        ),
      );
    } else {
      return Expanded(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("task")
              .where("email", isEqualTo: widget.user.email)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return new Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            return new TaskList(
              document: snapshot.data.documents,
            );
          },
        ),
      );
    }
  }

  Widget _buildTasksListCompleted() {
    return Expanded(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection("task")
            .where("email", isEqualTo: widget.user.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return new Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          return new TaskList(
            document: snapshot.data.documents,
          );
        },
      ),
    );
  }

  Widget _buildMyTasksHeader() {
    DateTime _date = new DateTime.now();
    String _today = "${_date.year}/${_date.month}/${_date.day}";
    return new Padding(
      padding: new EdgeInsets.only(left: 50.0, bottom: 1.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'My Tasks',
            style: new TextStyle(fontSize: 34.0),
          ),
          new Text(
            //****** */
            //此处需要加入自动获取时间
            //****** */
            _today,
            style: new TextStyle(color: Colors.blueGrey, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

//创建时间轴线
  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 26.0,
      child: new Container(
        width: 1.0,
        color: Colors.cyan[300],
      ),
    );
  }

//动态悬浮按钮
  Widget _buildFab() {
    return new Positioned(
        //悬浮按钮的位置
        top: _imageHeight - 100.0,
        right: -40.0,
        child: new AnimatedFab(
          //onClick: _changeFilterState,
          email: widget.user.email,
          callbackFunction: showCompleted,
        ));
  }

//是否显示completed task 的方法
  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }
} //_MainPageState

class TaskList extends StatelessWidget {
  TaskList({this.document});
  final List<DocumentSnapshot> document;

  final double dotSize = 20.0;

  BuildContext _scaffoldContext;

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String title = document[i].data['title'].toString();
        String note = document[i].data['note'].toString();
        DateTime _date = document[i].data['duedate'].toDate();
        String duedate = "${_date.year}/${_date.month}/${_date.day}";

        return Dismissible(
          key: new Key(document[i].documentID),
          onDismissed: (direction) {
            Firestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot =
                  await transaction.get(document[i].reference);
              await transaction.delete(snapshot.reference);
            });

            Scaffold.of(context).showSnackBar(new SnackBar(
              content: Text("Data deleted"),
              backgroundColor: Colors.teal[300],
              duration: Duration(seconds: 2),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 1.0, right: 16.0, bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.symmetric(horizontal: 37.0 - dotSize),
                  child: InkWell(
                    onTap: () {
                      _completeTask(document[i]);
                    },
                    child: new Container(
                      //增加空格间隙  height: dotSize
                      height: dotSize * 4,
                      width: dotSize,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: document[i].data['completed']
                              ? Colors.blue
                              : Colors.pink),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new EditTask(
                                      title: title,
                                      note: note,
                                      duedate:
                                          document[i].data['duedate'].toDate(),
                                      index: document[i].reference,
                                    ),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 1.0),
                              child: Text(
                                title,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  note,
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  duedate,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                /*new IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new EditTask(
                              title: title,
                              note: note,
                              duedate: document[i].data['duedate'].toDate(),
                              index: document[i].reference,
                            ),
                      ),
                    );
                  },
                )*/
              ],
            ),
          ),
        );
      },
    );
  }

  void _completeTask(DocumentSnapshot document) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(document.reference);
      await transaction.update(snapshot.reference, {
        //"title" : document.data['title'].toString(),
        //"note" : document.data['note'].toString(),
        //"duedate" : document.data["duedate"],
        "completed": document.data['completed'] ? false : true,
      });
    });
    Scaffold.of(_scaffoldContext).showSnackBar(new SnackBar(
      content: Text(document.data['completed']
          ? "Task is not Completed"
          : "Task Completed"),
      backgroundColor:
          document.data['completed'] ? Colors.pink[300] : Colors.teal[300],
      duration: Duration(seconds: 2),
    ));

    //Navigator.pop(context);
  }
}
