import 'package:flutter/material.dart';

class AsyncPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Future Page")),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: ListView(children: <Widget>[
              Row(children: <Widget>[
                _itemBtn('Future()', 1, Colors.pinkAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('async', 2, Colors.purpleAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('async-await', 3, Colors.blueAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('catchError', 4, Colors.blueGrey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('try-catch', 5, Colors.orange.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('async-await(3)', 6,
                    Colors.deepOrangeAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('async*', 7, Colors.green.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('async* listener', 8, Colors.teal.withOpacity(0.4))
              ]),
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
        print(_function01());
        break;
      case 2:
        print(_function02());
        break;
      case 3:
        print(await _function03());
        break;
      case 4:
        await _function04(1);
        break;
      case 5:
        await _function04(2);
        break;
      case 6:
        await _functionThen();
        break;
      case 7:
        await for (int num in _function06()) {
          print('current num = $num');
        }
        break;
      case 8:
        _function06().listen((num) => print('current num = $num'));
        break;
    }
    print('Current Button $index click --> end');
  }

  _function01() {
    var result = Future.delayed(Duration(seconds: 3), () {
      return 'Future.delayed 3s!';
    })
        .then((val) => print('Function01 -> then() -> $val'))
        .whenComplete(() => print('Function01 -> whenComplete!'));
    return 'Function01 -> $result';
  }

  Future<String> _function02() async {
    var result = Future.delayed(Duration(seconds: 3), () {
      return 'Future.delayed 3s!';
    })
        .then((val) => print('Function02 -> then() -> $val'))
        .whenComplete(() => print('Function02 -> whenComplete!'));
    return 'Function02 -> $result';
  }

  _function03() async {
    var result = await Future.delayed(Duration(seconds: 3), () {
      return 'Future.delayed 3s!';
    });
    return 'Function03 -> $result';
  }

  _function04(index) async {
    switch (index) {
      case 1:
        await Future.error(ArgumentError.notNull('Input'))
            .catchError((val) => print('Function04 -> $val'));
        break;
      case 2:
        try {
          await Future.error(ArgumentError.notNull('Input'));
        } catch (e) {
          print('Function04 -> catch -> $e');
        } finally {
          print('Function04 -> Finally!');
        }
        break;
    }
  }

  _function06() async* {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  _functionThen() async {
    await _itemThen01();
  }

  _itemThen01() async {
    await Future.delayed(Duration(seconds: 3), () {
      print('Future -> then(1) -> Future.delayed 3s!');
      return _itemThen02();
    });
  }

  _itemThen02() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('Future -> then(2) -> Future.delayed 2s!');
      return _itemThen03();
    });
  }

  _itemThen03() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('Future -> then(3) -> Future.delayed 2s!');
      return 'Future.delayed 2s!';
    }).whenComplete(() => print('Future whenComplete!'));
  }
}
