import 'package:flutter/material.dart';
import 'package:base/note/screens/home.dart';
import 'package:base/note/data/theme.dart';

class NotePage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  ThemeData theme = appThemeLight;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: MyHomePage(title: 'Home', changeTheme: setTheme),
    );
  }

  setTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      setState(() {
        theme = appThemeDark;
      });
    } else {
      setState(() {
        theme = appThemeLight;
      });
    }
  }
}
