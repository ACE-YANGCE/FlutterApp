import 'package:flutter/material.dart';
import 'package:flutter_app/page/ace_marquee_page.dart';
import 'package:flutter_app/page/ace_stepper_page.dart';
import 'package:flutter_app/page/async_page.dart';
import 'package:flutter_app/page/bloc_page.dart';
import 'package:flutter_app/page/future_page.dart';
import 'package:flutter_app/page/isolate_page.dart';
import 'package:flutter_app/page/media_query_page.dart';
import 'package:flutter_app/page/overlay_page.dart';
import 'package:flutter_app/page/tabbar_page.dart';
import 'package:flutter_app/widget/ace_stepper.dart';
import 'package:flutter_app/page/animated_cross_fade_page.dart';
import 'package:flutter_app/page/animated_switcher_page.dart';
import 'package:flutter_app/page/ace_checkbox_page.dart';
import 'package:flutter_app/page/drop_down_page.dart';
import 'package:flutter_app/page/stream_page.dart';
import 'package:flutter_app/page/ace_wave_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ACE Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(title: 'ACE Flutter Demo Home Page'),
        routes: {
          'aceStepperPage': (BuildContext context) => ACEStepperPage(),
          'animatedCrossFadePage': (BuildContext context) =>
              AnimatedCrossFadePage(),
          'animatedSwitcherPage': (BuildContext context) =>
              AnimatedSwitcherPage(),
          'aceMarqueePage': (BuildContext context) => ACEMarqueePage(),
          'aceCheckBoxPage': (BuildContext context) => ACECheckBoxPage(),
          'dropDownPage': (BuildContext context) => DropDownPage(),
          'tabBarPage': (BuildContext context) => TabBarPage(),
          'streamPage': (BuildContext context) => StreamPage(),
          'aceWavePage': (BuildContext context) => ACEWavePage(),
          'blocPage': (BuildContext context) => BlocPage(),
          'overlayPage': (BuildContext context) => OverLayPage(),
          'futurePage': (BuildContext context) => FuturePage(),
          'asyncPage': (BuildContext context) => AsyncPage(),
          'isolatePage': (BuildContext context) => IsolatePage(),
          'mediaQueryPage': (BuildContext context) => MediaQueryPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: ListView(children: <Widget>[
              Row(children: <Widget>[
                _itemWid('ACEStepper vertical', 0,
                    Colors.pinkAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemWid('ACEStepper horizontal', 1,
                    Colors.deepPurple.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemWid(
                    'AnimatedCrossFade', 2, Colors.blueAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemWid(
                    'AnimatedSwitcher', 3, Colors.blueGrey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemWid('ACEMarquee 跑马灯', 4, Colors.orange.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemWid('ACECheckBox 复选框', 5,
                    Colors.deepOrangeAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemWid('Dropdown 下拉框', 6, Colors.redAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemWid('TabBar 导航栏', 7, Colors.red.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemWid('Flutter Stream', 8, Colors.green.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemWid('ACEWave 波浪', 9, Colors.lightGreen.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemWid('Bloc Page', 10, Colors.indigoAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemWid('Overlay Page', 11, Colors.grey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemWid('Future Page', 12, Colors.orange.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemWid(
                    'Async Page', 13, Colors.deepOrangeAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemWid('Isolate Page', 14, Colors.redAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemWid('MediaQuery Page', 15, Colors.red.withOpacity(0.4))
              ]),
            ])),
        floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add)));
  }

  Widget _itemWid(itemStr, index, color) {
    return Expanded(
        child: FlatButton(
            onPressed: () => _itemClick(index),
            child: Text(itemStr, style: TextStyle(color: Colors.white)),
            color: color));
  }

  _itemClick(index) {
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ACEStepperPage(type: ACEStepperType.vertical);
        }));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ACEStepperPage(type: ACEStepperType.horizontal);
        }));
        break;
      case 2:
        Navigator.pushNamed(context, "animatedCrossFadePage");
        break;
      case 3:
        Navigator.pushNamed(context, 'animatedSwitcherPage');
        break;
      case 4:
        Navigator.pushNamed(context, 'aceMarqueePage');
        break;
      case 5:
        Navigator.pushNamed(context, 'aceCheckBoxPage');
        break;
      case 6:
        Navigator.pushNamed(context, 'dropDownPage');
        break;
      case 7:
        Navigator.pushNamed(context, 'tabBarPage');
        break;
      case 8:
        Navigator.pushNamed(context, 'streamPage');
        break;
      case 9:
        Navigator.pushNamed(context, 'aceWavePage');
        break;
      case 10:
        Navigator.pushNamed(context, 'blocPage');
        break;
      case 11:
        Navigator.pushNamed(context, 'overlayPage');
        break;
      case 12:
        Navigator.pushNamed(context, 'futurePage');
        break;
      case 13:
        Navigator.pushNamed(context, 'asyncPage');
        break;
      case 14:
        Navigator.pushNamed(context, 'isolatePage');
        break;
      case 15:
        Navigator.pushNamed(context, 'mediaQueryPage');
        break;
    }
  }
}
