import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

Function themer;

class SettingsPage extends StatefulWidget {
  SettingsPage(Function themerCallback) {
    themer = themerCallback;
  }

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _currentClass = '7CE2';
  String _currentTheme = 'Dark';
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getDefaults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Default Settings'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Column(
            children: <Widget>[
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    child: Text('7 CE - 1'),
                    value: '7CE1',
                  ),
                  DropdownMenuItem(
                    child: Text('7 CE - 2'),
                    value: '7CE2',
                  ),
                  DropdownMenuItem(
                    child: Text('7 CS - 1'),
                    value: '7CS1',
                  ),
                  DropdownMenuItem(
                    child: Text('7 CS - 2'),
                    value: '7CS2',
                  ),
                  DropdownMenuItem(
                    child: Text('7 IT - 1'),
                    value: '7IT1',
                  ),
                  DropdownMenuItem(
                    child: Text('7 IT - 2'),
                    value: '7IT2',
                  ),
                ],
                value: _currentClass,
                decoration: InputDecoration(labelText: 'Class'),
                onChanged: (v) {
                  setState(() {
                    _currentClass = v;
                  });
                  setClass();
                },
              ),
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    child: Text('Light'),
                    value: 'Light',
                  ),
                  DropdownMenuItem(
                    child: Text('Dark'),
                    value: 'Dark',
                  ),
                ],
                value: _currentTheme,
                decoration: InputDecoration(labelText: 'Theme'),
                onChanged: (v) {
                  setState(() {
                    _currentTheme = v;
                  });
                  setTheme();
                  themer(_currentTheme);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDefaults() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _currentClass = sharedPreferences.getString('class') ?? '7CE2';
      _currentTheme = sharedPreferences.getString('theme') ?? 'Dark';
    });
  }

  void setClass() async {
    sharedPreferences.setString('class', _currentClass);
  }

  void setTheme() async {
    sharedPreferences.setString('theme', _currentTheme);
  }
}
