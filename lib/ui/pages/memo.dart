import 'package:flutter/material.dart';
import 'package:base/memo/services/sharedPref.dart';
import 'package:base/memo/screens/home.dart';
import 'package:base/memo/data/theme.dart';


class MemoPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  ThemeData theme = appThemeLight;
  @override
  void initState() {
    super.initState();
    updateThemeFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  void updateThemeFromSharedPref() async {
    String themeText = await getThemeFromSharedPref();
    if (themeText == 'light') {
      setTheme(Brightness.light);
    } else {
      setTheme(Brightness.dark);
    }
  }
}
