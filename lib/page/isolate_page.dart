import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';

class IsolatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Future Page")),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: ListView(children: <Widget>[
              Row(children: <Widget>[
                _itemBtn(
                    'spawn Isolate', 1, Colors.pinkAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn(
                    'spawnUri Isolate', 2, Colors.purpleAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('单向通讯', 3, Colors.blueAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('双向通讯', 4, Colors.blueGrey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('compute()', 5, Colors.orange.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn(
                    'compute() 02', 6, Colors.deepOrangeAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('compute() Error', 7, Colors.pink.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('', 8, Colors.pinkAccent.withOpacity(0.4))
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

  _itemClick(index) async {
    print('Current Button $index click --> start');
    switch (index) {
      case 1:
        await _loadIsolateDate01();
        break;
      case 2:
        await _loadIsolateDate03();
        break;
      case 3:
        await _loadIsolateDate01();
        break;
      case 4:
        await _loadIsolateDate02();
        break;
      case 5:
        await _loadIsolateDate04();
        break;
      case 6:
        await _loadIsolateDate05(false);
        break;
      case 7:
        await _loadIsolateDate05(true);
        break;
    }
    print('Current Button $index click --> end');
  }

  _loadIsolateDate01() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_backgroundWork, receivePort.sendPort);
    receivePort.listen((val) => print('listen -> 【$val】'));
  }

  static _backgroundWork(SendPort sendPort) async {
    sendPort.send(
        'BackgroundWork -> currentTime -> ${DateTime.now().millisecondsSinceEpoch}');
    Future.delayed(Duration(seconds: 3), () {
      return sendPort.send(
          'BackgroundWork delayed 3s -> currentTime -> ${DateTime.now().millisecondsSinceEpoch}');
    });
  }

  _loadIsolateDate02() async {
    ReceivePort receivePort = ReceivePort();
    var sendPort;
    await Isolate.spawn(_backgroundWork2, receivePort.sendPort);
    receivePort.listen((val) {
      if (val is SendPort) {
        sendPort = val as SendPort;
        print("双向通讯建立成功");
      }
      print("Isolate Recevie Data -> 【$val】");
      if (sendPort != null) {
        sendPort.send(
            '_loadIsolateDate02 -> currentTime -> ${DateTime.now().millisecondsSinceEpoch}');
      }
    });
  }

  static _backgroundWork2(SendPort sendPort) async {
    ReceivePort receivePort = new ReceivePort();
    receivePort.listen((val) {
      print("Background Isolate Receive Data -> 【$val]");
    });
    sendPort.send(
        'BackgroundWork -> currentTime -> ${DateTime.now().millisecondsSinceEpoch}');
    sendPort.send(receivePort.sendPort);
    Future.delayed(Duration(seconds: 2), () {
      return sendPort.send(
          'BackgroundWork delayed 2s -> currentTime -> ${DateTime.now().millisecondsSinceEpoch}');
    });
    Future.delayed(Duration(seconds: 5), () {
      return sendPort.send(receivePort.sendPort);
    });
  }

  _loadIsolateDate03() async {
    ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawnUri(
        new Uri(path: "package:flutter_app04/utils/second_isolate.dart"),
        ['params01, params02,params03'],
        receivePort.sendPort);
    receivePort.listen((val) => print('listen -> 【$val】'));
//    isolate.kill(priority: Isolate.immediate);
  }

  _loadIsolateDate04() async {
    print('main Isolate, current Isolate = ${Isolate.current.hashCode}');
    print(await compute(getName, ''));
  }

  static String getName(String name) {
    print('new Isolate, current Isolate = ${Isolate.current.hashCode}');
    sleep(Duration(seconds: 2));
    return '阿策小和尚';
  }

  _loadIsolateDate05(bool isError) async {
    print('main Isolate, current Isolate = ${Isolate.current.hashCode}');
    try {
      print(await compute(_backgroundWork3, isError));
    } catch (e) {
      print(e);
    }
  }

  static _backgroundWork3(bool isError) async {
    print('new Isolate, current Isolate = ${Isolate.current.hashCode}');
    if (!isError) {
      return await Future.delayed(Duration(seconds: 2), () {
        return 'BackgroundWork delayed 2s -> currentTime -> ${DateTime.now().millisecondsSinceEpoch}';
      });
    } else {
      return await Future.error(ArgumentError.notNull('Input'));
    }
  }
}
