import 'package:flutter/material.dart';
import 'package:base/core/services/auth-service.dart';
import 'package:base/ui/shared/menuclipper.dart';
import 'package:base/ui/pages/navigation.dart';
import 'package:base/ui/pages/memo.dart';
//import 'package:base/ui/pages/scheduler.dart';

class DashboardMain extends StatefulWidget {
  DashboardMain(
      {Key key, this.auth, this.userId, this.logoutCallback, this.userEmail})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String userEmail;

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: buildDrawer(),
      body: Text('Home'),
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
            MaterialPageRoute(builder: (context) => MemoPage()));
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
