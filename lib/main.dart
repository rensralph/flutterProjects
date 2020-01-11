import 'package:flutter/material.dart';
import 'package:base/ui/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAIU',
      theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.greenAccent),
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}