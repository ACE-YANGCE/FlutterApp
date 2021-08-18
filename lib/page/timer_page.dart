import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_timer_button.dart';

class TimerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Timer Page")), body: _bodyWid());
  }

  _bodyWid() => ListView(children: <Widget>[
        _itemWid('Timer()', 0, Colors.pink.withOpacity(0.4)),
        _itemWid('Timer.periodic()', 1, Colors.deepOrange.withOpacity(0.4)),
        _itemWid('Timer.run()', 2, Colors.deepPurple.withOpacity(0.4)),
        _itemWid(
            'Timer.periodic() & cancel()', 3, Colors.blue.withOpacity(0.4)),
        Row(children: [
          Expanded(
              child: _itemWid(
                  'Timer.periodic()', 4, Colors.brown.withOpacity(0.4))),
          Expanded(
              child: _itemWid('cancel()', 5, Colors.brown.withOpacity(0.4)))
        ]),
        SizedBox(height: 20.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ACETimerButton(30, preName: '获取验证码', color: Colors.green)
        ])
      ]);

  _itemWid(text, index, color) => Padding(
      child: FlatButton(
          onPressed: () => _itemClick(index),
          child: Text(text, style: TextStyle(color: Colors.white)),
          color: color),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0));

  _itemClick(index) async {
    switch (index) {
      case 0:
        _timer01();
        break;
      case 1:
        _timer02();
        break;
      case 2:
        _timer03();
        break;
      case 3:
        _timer04();
        break;
      case 4:
        _timer05();
        break;
      case 5:
        _timer?.cancel();
        break;
    }
  }

  _timer01() {
    Timer(Duration(seconds: 3), () {
      print('_timer01() -> Timer(Duration(seconds: 3) printed after 3 seconds');
      // Toast.show('Timer(Duration(seconds: 3) printed after 3 seconds !', context,
      //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    });
  }

  _timer02() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      print('_timer02() -> Timer.periodic() -> Timer.tick -> ${timer.tick} ->'
          ' Timer.isActive -> ${timer.isActive}');
    });
  }

  _timer03() {
    print('_timer03() -> A');
    Timer.run(() {
      print('_timer03() -> Timer.run()');
    });
    print('_timer03() -> B');
    Timer(Duration.zero, () {
      print('_timer03() -> Duration.zero');
    });
    print('_timer03() -> C');
  }

  _timer04() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (timer.tick == 3) {
        timer.cancel();
      }
      print('_timer04() -> Timer.periodic() -> Timer.tick -> ${timer.tick} ->'
          ' Timer.isActive -> ${timer.isActive}');
    });
  }

  _timer05() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      print('_timer05() -> Timer.periodic() -> Timer.tick -> ${timer.tick} ->'
          ' Timer.isActive -> ${timer.isActive}');
    });
  }
}
