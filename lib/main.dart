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
  Color _primarySwatch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalcy",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: _theme, primarySwatch: _primarySwatch),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/department': (context) => DepartmentPage(),
        '/settings': (context) => SettingsPage(this.themer),
      },
    );
  }

  void themer(String theme, String primarySwatch) {
    setState(() {
      _theme = theme == 'Dark' ? Brightness.dark : Brightness.light;
      switch(primarySwatch) {
        case 'Blue':
          _primarySwatch = Colors.blue;
          break;
        case 'Indigo':
          _primarySwatch = Colors.indigo;
          break;
        case 'Cyan':
          _primarySwatch = Colors.cyan;
          break;
        case 'Light Blue':
          _primarySwatch = Colors.lightBlue;
          break;
        case 'Teal':
          _primarySwatch = Colors.teal;
          break;
        case 'Red':
          _primarySwatch = Colors.red;
          break;
        case 'Green':
          _primarySwatch = Colors.green;
          break;
        case 'Yellow':
          _primarySwatch = Colors.yellow;
          break;
        case 'Lime':
          _primarySwatch = Colors.lime;
          break;
        case 'Amber':
          _primarySwatch = Colors.amber;
          break;
        case 'Orange':
          _primarySwatch = Colors.orange;
          break;
        case 'Deep Orange':
          _primarySwatch = Colors.deepOrange;
          break;
        case 'Purple':
          _primarySwatch = Colors.purple;
          break;
        case 'Deep Purple':
          _primarySwatch = Colors.deepPurple;
          break;
        case 'Brown':
          _primarySwatch = Colors.brown;
          break;
        case 'Pink':
          _primarySwatch = Colors.pink;
          break;
      }
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
