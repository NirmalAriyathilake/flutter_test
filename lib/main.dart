import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'FancyButton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  Color _color = Colors.amber;
  int i = -1;
  double _angle = 0;
  bool switchValue = false;
  int _selectedTabIndex = 0;
  AnimationController _animationController;
  bool _isPlaying = false;

  List<Color> _colors = [
    Colors.purple,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.amber,
    Colors.teal,
    Colors.lime,
    Colors.red
  ];

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

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

  void _playAnimated() {
    if (_isPlaying) {
      _animationController.reverse();
      _isPlaying = false;
    } else {
      _animationController.forward();
      _isPlaying = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      android: (_) => MaterialScaffoldData(
            floatingActionButton: FancyButton(
              onPressed: _incrementCounter,
            ),
          ),
      bottomNavBar: PlatformNavBar(
        currentIndex: _selectedTabIndex,
        itemChanged: (index) => setState(
              () {
                _selectedTabIndex = index;
              },
            ),
        android: (_) => MaterialNavBarData(items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.flag),
                title: Text("Android 1"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flag),
                title: Text("Android 3"),
              ),
            ]),
        ios: (_) => CupertinoTabBarData(items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.flag),
                title: Text("iOS 1"),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.flag),
                title: Text("iOS 2"),
              ),
            ]),
      ),
      appBar: PlatformAppBar(
        title: Text(widget.title),
      ),
      body: Transform.rotate(
        angle: _angle,
        child: AnimatedContainer(
          color: _color,
          duration: Duration(seconds: 1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CupertinoSwitch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    }),
                Text(
                  'You have pushed the button this many times:',
                ),
                PlatformCircularProgressIndicator(),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display2,
                ),
                IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController,
                  ),
                  onPressed: _playAnimated,
                ),
                CupertinoButton(
                  child: Text(
                    'Launch Action sheet',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: Text('Some Choices'),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text('One1'),
                              onPressed: () {
                                Navigator.pop(context, 1);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text('Two2'),
                              onPressed: () {
                                Navigator.pop(context, 1);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text('Three'),
                              onPressed: () {
                                Navigator.pop(context, 1);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text('Four'),
                              onPressed: () {
                                Navigator.pop(context, 1);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
