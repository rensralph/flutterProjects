import 'package:flutter/material.dart';
import 'package:base/core/services/auth-service.dart';
import 'package:base/ui/widgets/menu.dart';


class DashboardMain extends StatefulWidget {
  DashboardMain({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain>  {
 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              buildDrawer(context);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              widget.auth.signOut();
              widget.logoutCallback();
            },
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            )),
         body: Center(
            child: Text(
          "Hey, you've logged in successfully",
          style: TextStyle(fontSize: 20.0),
        ))
    );
  }

}

