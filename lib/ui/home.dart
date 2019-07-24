import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:Kalcy/data/timetable.dart';
import 'package:Kalcy/data/professors.dart';
import 'package:Kalcy/data/days.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _weekDay = DateTime.now().weekday;
  String _class;
  SharedPreferences _sharedPreferences;

  @override
  void initState() {
    super.initState();
    getDefaults();
  }

  void getDefaults() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _class = _sharedPreferences.getString('class');
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic cardData = 'Holiday';
    int i = 0;
    if (_weekDay < 6 && _class != null) {
      List<String> timings = timetable[_class][_weekDay].keys.toList();
      cardData = timetable[_class][_weekDay]
          .values
          .map((lecture) => ListTile(
                trailing: Text(
                  timings[i++],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Theme.of(context).primaryColorBrightness ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                isThreeLine: true,
                subtitle: Text(
                  professors[_class.substring(0, 3)][lecture.contains('Lab')
                          ? lecture.split('-')[0].trim()
                          : lecture]
                      .toString(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColorBrightness ==
                              Brightness.dark
                          ? Colors.white70
                          : Colors.black54),
                ),
                title: Text(
                  lecture,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColorBrightness ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ))
          .toList();
    }
    return _class == null
        ? Scaffold(
            appBar: AppBar(
              title: Text('Select Default Class'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    child: DropdownButtonFormField(
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
                      hint: Text('Select Default Class'),
                      value: _class,
                      onChanged: (v) {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                title: Text(
                                    'Do you want to set \"$v\" as your default class.'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () async {
                                      setState(() async {
                                        _class = v;
                                        _sharedPreferences.setString(
                                            'class', _class);
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                                content: Text(
                                    'You can always change it later from settings.'),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Kalcy'),
              actions: <Widget>[
                GestureDetector(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.school,
                                size: 20,
                              )),
                          Text(_class)
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) => Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        '7 CE - 1',
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _class = '7CE1';
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        '7 CE - 2',
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _class = '7CE2';
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        '7 CS - 1',
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _class = '7CS1';
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        '7 CS - 2',
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _class = '7CS2';
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        '7 IT - 1',
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _class = '7IT1';
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        '7 IT - 2',
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _class = '7IT2';
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                ),
                GestureDetector(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.today,
                                size: 20,
                              )),
                          Text(days[_weekDay]),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) => Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        'Today',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _weekDay = DateTime.now().weekday;
                                          Navigator.of(context).pop();
                                        });
                                      },
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
                              ),
                            ));
                  },
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.yellow),
                    child: Center(
                        child: Image.asset(
                      'assets/app.png',
                      width: 70,
                      height: 70,
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
                            applicationVersion: "1.0.3",
                            applicationIcon: Image.asset(
                              'assets/app.png',
                              width: 45,
                            ),
                            children: [
                              Text("Kayo Lecture Chhe?"),
                              Text(
                                "\nMade with \u2764 by Tirth",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              child: TimeTableCard(cardData),
            ),
          );
  }
}

class TimeTableCard extends StatelessWidget {
  final dynamic _data;

  TimeTableCard(this._data);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.all(30),
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
                  style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 3,
                      color: Theme.of(context).primaryColorBrightness ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black),
                ),
        ),
      ),
    );
  }
}
