import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:Kalcy/ui/home.dart';
import 'package:Kalcy/ui/department.dart';
import 'package:Kalcy/ui/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Brightness _theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalcy",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: _theme),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/department': (context) => DepartmentPage(),
        '/settings': (context) => SettingsPage(this.themer),
      },
    );
  }

  void themer(String theme) {
    setState(() {
      _theme = theme == 'Dark' ? Brightness.dark : Brightness.light;
    });
  }

  @override
  void initState() {
    super.initState();
    getDefaults();
  }

  void getDefaults() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.getString('theme') == 'Light') {
        _theme = Brightness.light;
      } else {
        _theme = Brightness.dark;
      }
    });
  }
}
