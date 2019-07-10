import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flip_card/flip_card.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kalcy/data/timetable.dart';
import 'package:kalcy/data/professors.dart';
import 'package:kalcy/data/days.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _weekDay = DateTime.now().weekday;
  String _class = '7CE2';
  String _theme = 'Dark';

  @override
  void initState() {
    super.initState();
    getDefaults();
  }

  void getDefaults() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _class = sharedPreferences.getString('class') ?? '7CE2';
      _theme = sharedPreferences.getString('theme') ?? 'Dark';
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic frontData = 'Holiday';
    int i = 0;
    if (_weekDay < 6) {
      List<String> timings = timetable[_class][_weekDay].keys.toList();
      frontData = timetable[_class][_weekDay]
          .values
          .map((lecture) => ListTile(
                trailing: Text(
                  timings[i++],
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ),
                isThreeLine: true,
                subtitle: Text(professors[lecture].toString()),
                title: Text(
                  lecture,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ))
          .toList();
    }
    return Scaffold(
        appBar: AppBar(
          brightness: _theme == 'Light' ? Brightness.light : Brightness.dark,
          title: Text('Kalcy'),
          actions: <Widget>[
            GestureDetector(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _class,
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
                      onChanged: (v) {
                        setState(() {
                          _class = v;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  'Today',
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  setState(() {
                                    _weekDay = DateTime.now().weekday;
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                              Divider(
                                height: 2,
                                color: Colors.white,
                              ),
                              ListTile(
                                title: Text(
                                  'Monday',
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  setState(() {
                                    _weekDay = 1;
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Tuesday',
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  setState(() {
                                    _weekDay = 2;
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Wednesday',
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  setState(() {
                                    _weekDay = 3;
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Thursday',
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  setState(() {
                                    _weekDay = 4;
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Friday',
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  setState(() {
                                    _weekDay = 5;
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                            ],
                          ),
                        ));
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Text(days[_weekDay]),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    color: _theme == 'Dark'
                        ? Colors.blueGrey[800]
                        : Colors.blue[100]),
                child: Center(
                    child: FlutterLogo(
                  colors: Colors.yellow,
                  size: 50,
                )),
              ),
              InkWell(
                splashColor: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Department'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/department');
                  },
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              InkWell(
                splashColor: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ),
              InkWell(
                splashColor: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    showAboutDialog(
                        context: context,
                        applicationName: "Kalcy",
                        applicationVersion: "1.0.1",
                        applicationIcon: Center(
                            child: Image.asset(
                          'assets/app.png',
                          width: 40,
                          height: 40,
                        )),
                        children: [Text("Kayo Lecture Chhe?")]);
                  },
                ),
              ),
            ],
          ),
        ),
        body: FlipCard(
          front: FrontCard(frontData, _theme),
          back: BackCard(_theme),
        ));
  }
}

class FrontCard extends StatelessWidget {
  final dynamic _data;
  final dynamic _theme;

  FrontCard(this._data, this._theme);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: _theme == 'Dark' ? Colors.blueGrey[800] : Colors.amber[800],
        margin: EdgeInsets.all(40),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: _data is List
              ? ListView(
                  children: <Widget>[
                    ..._data,
                  ],
                  padding: EdgeInsets.all(24),
                )
              : Text(
                  _data,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, letterSpacing: 3),
                ),
        ),
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  final dynamic _theme;

  BackCard(this._theme);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: _theme == 'Dark' ? Colors.blueGrey[800] : Colors.amber[800],
        margin: EdgeInsets.all(40),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: FutureBuilder(
            builder: (BuildContext buildContext, AsyncSnapshot snapShot) {
              switch (snapShot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Text(
                    'Peace of mind is the highest wealth.',
                    textAlign: TextAlign.center,
                  );
                case ConnectionState.done:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapShot.data,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                    ),
                  );
              }
            },
            future: getRandomQuote(),
            initialData: Text("Hello World!"),
          ),
        ),
      ),
    );
  }
}

Future getRandomQuote() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      dynamic response =
          await http.get('https://geek-jokes.sameerkumar.website/api');
      response = jsonDecode(response.body);
      return response.toString();
    }
  } on SocketException catch (_) {
    return 'Peace of mind is the highest wealth.';
  }
}
