import 'package:flutter/material.dart';

void main() => runApp(Info());

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var card = new Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(5.0),
          title: new Text(
            'Login & Logout',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: new Text('Login: use google account\nLogout: press the "logout" button in the top right corner'),
          leading: new Icon(
            Icons.account_circle,
            color: Colors.teal[300],
            size: 40.0,
          ),
        ),
        new Divider(),
        
        ListTile(
          contentPadding: EdgeInsets.all(5.0),
          title: new Text(
            'ADD Task',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle:
              new Text('Tap the control button and tap the " + " button '),
          leading: new Icon(
            Icons.add_circle,
            color: Colors.teal[300],
            size: 40.0,
          ),
        ),
        new Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(5.0),
          title: new Text(
            'Delete Task',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: new Text(
              'Find the task you want to delete and then swap it to the right or left'),
          leading: new Icon(
            Icons.remove_circle,
            color: Colors.teal[300],
            size: 40.0,
          ),
        ),
        new Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(5.0),
          title: new Text(
            'Edit Task',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: new Text(
              'Click the task you want to edit and amend the information'),
          leading: new Icon(
            Icons.mode_edit,
            color: Colors.teal[300],
            size: 40.0,
          ),
        ),
        new Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(5.0),
          title: new Text(
            'Complete Task',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: new Text(
              'Tap the colour circle in front of the task\nPink colour indicates the on going task and Blue colour indicates the completed task'),
          leading: new Icon(
            Icons.check_circle,
            color: Colors.teal[300],
            size: 40.0,
          ),
        ),

        new Divider(),
        new Text("Simple Task", style: TextStyle(
          fontFamily: "Pacifico",
          fontSize: 20.0,
          color: Colors.teal,
        ),),
        new Text(
          "more information: P78073012@mail.ncku.edu.tw",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.teal[600],
              fontSize: 11.0),
        )
      ],
    ));

    return MaterialApp(
      title: 'ListView widget',
      home: Scaffold(
        appBar: new AppBar(
          //centerTitle: Text('卡片布局'),
          title: new Text('INSTRUCTIONS'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)),
          elevation: 5.0, //增加阴影
          backgroundColor: Colors.teal[500],
        ),
        body: Center(child: card),
      ),
    );
  }
}
