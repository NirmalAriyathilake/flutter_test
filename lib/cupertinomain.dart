import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

class CupertinoMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        primaryColor: Colors.teal,
      ),
      home: CupertinoMyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class CupertinoMyHomePage extends StatefulWidget {
  CupertinoMyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CupertinoMyHomePageState createState() => _CupertinoMyHomePageState();
}

class _CupertinoMyHomePageState extends State<CupertinoMyHomePage> {
  int _counter = 0;
  Color _color = Colors.red;
  int i = -1;
  double _angle = 0;

  List<Color> _colors = [
    Colors.purple,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.amber,
    Colors.teal,
    Colors.lime,
    Colors.red,
    Colors.white
  ];

  void _incrementCounter() {
    if (i < _colors.length - 1)
      i++;
    else
      i = 0;

    setState(() {
      _counter++;
      _angle = _angle + pi / 4;
      _color = _colors[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Transform.rotate(
        angle: _angle,
        child: AnimatedContainer(
          color: _color,
          duration: Duration(seconds: 2),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display2,
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
