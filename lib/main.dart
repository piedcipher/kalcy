import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:Kalcy/ui/home.dart';
import 'package:Kalcy/ui/department.dart';
import 'package:Kalcy/ui/settings.dart';
import 'package:Kalcy/data/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Brightness _theme;
  Color _primarySwatch;

  @override
  void initState() {
    super.initState();
    getDefaults();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalcy",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _theme,
        primarySwatch: _primarySwatch,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/department': (context) => DepartmentPage(),
        '/settings': (context) => SettingsPage(this.themer),
      },
    );
  }

  void getDefaults() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _theme = appTheme[sharedPreferences.getString('theme') ?? 'Dark'];
      _primarySwatch = primarySwatchThemes[
          sharedPreferences.getString('primarySwatch') ?? 'Blue'];
    });
  }

  void themer(String theme, String primarySwatch) {
    setState(() {
      _theme = appTheme[theme];
      _primarySwatch = primarySwatchThemes[primarySwatch];
    });
  }
}
