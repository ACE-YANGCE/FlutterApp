import 'dart:async';

import 'package:flutter/material.dart';

class TaskQueuePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TaskQueuePageState();
}

class _TaskQueuePageState extends State<TaskQueuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("TaskQueue Page")),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: ListView(children: <Widget>[
              Row(children: <Widget>[
                _itemBtn('1. Future() 基本构造函数', 1, Colors.green.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('2. Future.microtask()', 2,
                    Colors.pinkAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn(
                    '3. Future.sync()', 3, Colors.blueAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn(
                    '4. Future.then()', 4, Colors.blueGrey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('5. Future.whenComplete()', 5,
                    Colors.orange.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('6. Future.then() + Future()', 6,
                    Colors.purpleAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('7. Future.then() + Future() 对比 6', 7,
                    Colors.brown.withOpacity(0.4))
              ])
            ])));
  }

  _itemBtn(text, index, color) {
    return Expanded(
        child: FlatButton(
            onPressed: () => _itemClick(index),
            child: Center(
                child: Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 16.0))),
            color: color));
  }

  _itemClick(index) {
    print('Current Button $index click --> start');
    switch (index) {
      case 1:
        _taskQueue01();
        break;
      case 2:
        _taskQueue02();
        break;
      case 3:
        _taskQueue03();
        break;
      case 4:
        _taskQueue04();
        break;
      case 5:
        _taskQueue05();
        break;
      case 6:
        _taskQueue06();
        break;
      case 7:
        _taskQueue07();
        break;
      default:
        _taskQueue10();
        break;
    }
    print('Current Button $index click --> end');
  }

  _taskQueue01() {
    Future(() => print('TaskQueue -> Future A'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask A'));
    Future.delayed(
        Duration(seconds: 2), () => print('TaskQueue -> Future.delayed B'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask B'));
    Future(() => print('TaskQueue -> Future C'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask C'));
  }

  _taskQueue02() {
    Future(() => print('TaskQueue -> Future A'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask A'));
    Future.delayed(
        Duration(seconds: 2), () => print('TaskQueue -> Future.delayed B'));
    Future.microtask(() => print('TaskQueue -> Future.microtask B'));
    Future(() => print('TaskQueue -> Future C'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask C'));
  }

  _taskQueue03() {
    Future(() => print('TaskQueue -> Future A'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask A'));
    Future.sync(() => print('TaskQueue -> Future.sync D'));
    Future.delayed(
        Duration(seconds: 2), () => print('TaskQueue -> Future.delayed B'));
    Future.microtask(() => print('TaskQueue -> Future.microtask B'));
    Future(() => print('TaskQueue -> Future C'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask C'));
  }

  _taskQueue04() {
    Future(() => print('TaskQueue -> Future A'))
        .then((_) => print('TaskQueue -> Future A -> then()01'))
        .then((_) => print('TaskQueue -> Future A -> then()02'));
    Future.sync(() => print('TaskQueue -> Future.sync D'))
        .then((_) => print('TaskQueue -> Future.sync D -> then()01'))
        .then((_) => print('TaskQueue -> Future.sync D -> then()02'));
    Future.delayed(
            Duration(seconds: 2), () => print('TaskQueue -> Future.delayed B'))
        .then((_) => print('TaskQueue -> Future.delayed B -> then()01'))
        .then((_) => print('TaskQueue -> Future.delayed B -> then()02'));
    Future.microtask(() => print('TaskQueue -> Future.microtask B'))
        .then((_) => print('TaskQueue -> Future.microtask B -> then()01'))
        .then((_) => print('TaskQueue -> Future.microtask B -> then()02'));
    Future(() => print('TaskQueue -> Future C'))
        .then((_) => print('TaskQueue -> Future C -> then()01'))
        .then((_) => print('TaskQueue -> Future C -> then()02'));
  }

  _taskQueue05() {
    Future(() => print('TaskQueue -> Future A'))
        .then((_) => print('TaskQueue -> Future A -> then()01'))
        .then((_) => print('TaskQueue -> Future A -> then()02'))
        .whenComplete(() => print('TaskQueue -> Future A -> whenComplete()'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask A'));
    Future.sync(() => print('TaskQueue -> Future.sync D'))
        .then((_) => print('TaskQueue -> Future.sync D -> then()01'))
        .then((_) => print('TaskQueue -> Future.sync D -> then()02'))
        .whenComplete(
            () => print('TaskQueue -> Future.sync D -> whenComplete()'));
    Future.delayed(
            Duration(seconds: 2), () => print('TaskQueue -> Future.delayed B'))
        .then((_) => print('TaskQueue -> Future.delayed B -> then()01'))
        .then((_) => print('TaskQueue -> Future.delayed B -> then()02'))
        .whenComplete(
            () => print('TaskQueue -> Future.delayed B -> whenComplete()'));
    Future.microtask(() => print('TaskQueue -> Future.microtask B'))
        .then((_) => print('TaskQueue -> Future.microtask B -> then()01'))
        .then((_) => print('TaskQueue -> Future.microtask B -> then()02'))
        .whenComplete(
            () => print('TaskQueue -> Future.microtask B -> whenComplete()'));
    Future(() => print('TaskQueue -> Future C'))
        .then((_) => print('TaskQueue -> Future C -> then()01'))
        .then((_) => print('TaskQueue -> Future C -> then()02'))
        .whenComplete(() => print('TaskQueue -> Future C -> whenComplete()'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask C'));
  }

  _taskQueue06() {
    Future(() => print('TaskQueue -> Future A'))
        .then((_) {
          print('TaskQueue -> Future A -> then()01');
          return Future.delayed(Duration(seconds: 1),
              () => print('TaskQueue -> Future.delayed D'));
        })
        .then((_) => print('TaskQueue -> Future A -> then()02'))
        .whenComplete(() => print('TaskQueue -> Future A -> whenComplete()'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask A'));
    Future.delayed(
            Duration(seconds: 2), () => print('TaskQueue -> Future.delayed B'))
        .then((_) => print('TaskQueue -> Future.delayed B -> then()01'))
        .then((_) => print('TaskQueue -> Future.delayed B -> then()02'))
        .whenComplete(
            () => print('TaskQueue -> Future.delayed B -> whenComplete()'));
    Future(() => print('TaskQueue -> Future C'))
        .then((_) {
          print('TaskQueue -> Future C -> then()01');
          return scheduleMicrotask(
              () => print('TaskQueue -> scheduleMicrotask C'));
        })
        .then((_) => print('TaskQueue -> Future C -> then()02'))
        .whenComplete(() => print('TaskQueue -> Future C -> whenComplete()'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask B'));
  }

  _taskQueue07() {
    Future(() => print('TaskQueue -> Future A'))
        .then((_) {
          print('TaskQueue -> Future A -> then()01');
          Future.delayed(Duration(seconds: 1),
              () => print('TaskQueue -> Future.delayed D'));
        })
        .then((_) => print('TaskQueue -> Future A -> then()02'))
        .whenComplete(() => print('TaskQueue -> Future A -> whenComplete()'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask A'));
    Future.delayed(
            Duration(seconds: 2), () => print('TaskQueue -> Future.delayed B'))
        .then((_) => print('TaskQueue -> Future.delayed B -> then()01'))
        .then((_) => print('TaskQueue -> Future.delayed B -> then()02'))
        .whenComplete(
            () => print('TaskQueue -> Future.delayed B -> whenComplete()'));
    Future(() => print('TaskQueue -> Future C'))
        .then((_) {
          print('TaskQueue -> Future C -> then()01');
          scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask C'));
        })
        .then((_) => print('TaskQueue -> Future C -> then()02'))
        .whenComplete(() => print('TaskQueue -> Future C -> whenComplete()'));
    scheduleMicrotask(() => print('TaskQueue -> scheduleMicrotask B'));
  }

  _taskQueue10() {
    scheduleMicrotask(() => print('microtask #1 of 3'));

    Future.delayed(Duration(seconds: 1), () => print('future #1 (delayed)'));

    Future(() => print('future #2 of 4'))
        .then((_) => print('future #2a'))
        .then((_) {
      print('future #2b');
      scheduleMicrotask(() => print('microtask #0 (from future #2b)'));
    }).then((_) => print('future #2c'));

    scheduleMicrotask(() => print('microtask #2 of 3'));

    Future(() => print('future #3 of 4'))
        .then((_) => new Future(() => print('future #3a (a new future)')))
        .then((_) => print('future #3b'));

    Future(() => print('future #4 of 4'));
    scheduleMicrotask(() => print('microtask #3 of 3'));
  }
}
