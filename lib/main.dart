import 'package:flutter/material.dart';
import 'package:flutter_app/page/ace_stepper_page.dart';
import 'package:flutter_app/widget/ace_stepper.dart';

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
              ])
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
    }
  }
}
