import 'package:base/core/services/auth-service.dart';
import 'package:base/ui/pages/navigation.dart';
import 'package:base/ui/shared/menuclipper.dart';
import 'package:base/ui/views/main-page.dart';
import 'package:flutter/material.dart';
import 'package:base/memo/user.dart';
import 'dart:async';
import 'package:base/memo/db_helper.dart';
 
class MemoPage extends StatefulWidget {
  final String title;
 
  MemoPage({Key key, this.title, this.auth, this.userId, this.logoutCallback, this.userEmail}) : super(key: key);
 
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String userEmail;
  @override
  State<StatefulWidget> createState() {
    return _MemoPageState();
  }
}
 
class _MemoPageState extends State<MemoPage> {
  //
  Future<List<User>> users;
  TextEditingController controller = TextEditingController();
  String name;
  int curUserId;
 
  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;
 
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }
 
  refreshList() {
    setState(() {
      users = dbHelper.getEmployees();
    });
  }
 
  clearName() {
    controller.text = '';
  }
 
  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        User e = User(curUserId, name);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        User e = User(null, name);
        dbHelper.save(e);
      }
      clearName();
      refreshList();
    }
  }
 
  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'UPDATE' : 'ADD'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
 
  SingleChildScrollView dataTable(List<User> users) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('NAME'),
          ),
          DataColumn(
            label: Text('DELETE'),
          )
        ],
        rows: users
            .map(
              (user) => DataRow(cells: [
                    DataCell(
                      Text(user.name),
                      onTap: () {
                        setState(() {
                          isUpdating = true;
                          curUserId = user.id;
                        });
                        controller.text = user.name;
                      },
                    ),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        dbHelper.delete(user.id);
                        refreshList();
                      },
                    )),
                  ]),
            )
            .toList(),
      ),
    );
  }
 
  list() {
    return Expanded(
      child: FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
 
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }
 
          return CircularProgressIndicator();
        },
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      drawer: buildDrawer(),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
   Widget buildDrawer() {
    final String _img = "assets/logo.png";
    return ClipPath(
      clipper: MenuClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: Colors.blue[700],
            boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300.0,
        height: double.maxFinite,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.blue[200], Colors.blue[700]])),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(_img),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  widget.userEmail.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                SizedBox(height: 30.0),
                _buildRow(Icons.home, "Home"),
                _buildDivider(),
                _buildRow2(Icons.note, "Memo"),
                _buildDivider(),
                _buildRow3(Icons.book, "Journal"),
                _buildDivider(),
                _buildRow4(Icons.schedule, "Scheduler"),
                _buildDivider(),
                _buildRow5(Icons.navigation, "Navigation"),
                _buildDivider(),
                _buildRow6(Icons.exit_to_app, "Logout"),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.blue[200],
    );
  }

  Widget _buildRow6(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

    return FlatButton(
      onPressed: () {
        widget.auth.signOut();
        widget.logoutCallback();
      },
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(icon, color: Colors.blue[200]),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }

  Widget _buildRow5(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MapsDemo()));
      },
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(icon, color: Colors.blue[200]),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }

  Widget _buildRow4(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MapsDemo()));
      },
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(icon, color: Colors.blue[200]),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }

  Widget _buildRow3(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MapsDemo()));
      },
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(icon, color: Colors.blue[200]),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }

  Widget _buildRow2(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MapsDemo()));
      },
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(icon, color: Colors.blue[200]),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }

  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.blue[200], fontSize: 16.0);

    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashboardMain()));
      },
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(icon, color: Colors.blue[200]),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }
}