import 'package:flutter/material.dart';

class FuturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
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
                _itemBtn(
                    'Future.value()', 2, Colors.purpleAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn(
                    'Future.delay()', 3, Colors.blueAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('Future.sync()', 4, Colors.blueGrey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('Future.error()', 5, Colors.orange.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('Future.microtask()', 6,
                    Colors.deepOrangeAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('Future TimeOut', 7, Colors.green.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('Future Any01', 8, Colors.teal.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('Future Any02', 9, Colors.red.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('Future Any03', 10, Colors.redAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn(
                    'Future doWhile', 11, Colors.indigoAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('Future ForEach', 12, Colors.amber.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('Future Wait', 13, Colors.pinkAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('Future Wait Error01', 14,
                    Colors.purpleAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('Future Wait Error02', 15,
                    Colors.blueAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn(
                    'Future Wait cleanUp', 16, Colors.blueGrey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('Three then()', 17, Colors.orange.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('Three then02()', 18,
                    Colors.deepOrangeAccent.withOpacity(0.4))
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

  _itemClick(index) {
    print('Current Button $index click --> start');
    switch (index) {
      case 1:
        _futureConstructor01();
        break;
      case 2:
        _futureConstructor02();
        break;
      case 3:
        _futureConstructor03();
        break;
      case 4:
        _futureConstructor04();
        break;
      case 5:
        _futureConstructor05();
        break;
      case 6:
        _futureConstructor06();
        break;
      case 7:
        _futureConstructor07();
        break;
      case 8:
        _futureAny(0);
        break;
      case 9:
        _futureAny(1);
        break;
      case 10:
        _futureAny(2);
        break;
      case 13:
        _futureWait(1);
        break;
      case 12:
        _futureForEach();
        break;
      case 11:
        _futureDoWhile();
        break;
      case 14:
        _futureWait(2);
        break;
      case 15:
        _futureWait(3);
        break;
      case 16:
        _futureWait(4);
        break;
      case 17:
        _futureMoreThen();
        break;
      case 18:
        _futureMoreThen02();
        break;
    }
    print('Current Button $index click --> end');
  }

  _futureConstructor01() {
    Future(() => print('Future(FutureOr<T> computation()) 01'));
    Future(() {
      print('Future(FutureOr<T> computation()) 02');
      return 'Future(FutureOr<T> computation()) 02 result!';
    }).then((val) => print(val));
    Future(() {
      print('Future(FutureOr<T> computation()) 03');
      return 'Future(FutureOr<T> computation()) 03 result!';
    }).then((val) => print(val)).whenComplete(
        () => print('Future(FutureOr<T> computation()) 03 whenComplete!'));
  }

  _futureConstructor02() {
    Future.value('Future.value() 01').then((val) => print(val));
    Future.value('Future.value() 02').then((val) => print(val));
    Future.value('Future.value() 03')
        .then((val) => print(val))
        .whenComplete(() => print('Future.value() 03 whenComplete!'));
  }

  _futureConstructor03() {
    print('CurrentTime01 = ${DateTime.now().millisecondsSinceEpoch}');
    Future.delayed(
        Duration(seconds: 3),
        () => print(
            'Future.delayed() 01, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'));
    print('CurrentTime02 = ${DateTime.now().millisecondsSinceEpoch}');
    Future.delayed(
        Duration(seconds: 1),
        () => print(
            'Future.delayed() 02, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'));
    print('CurrentTime03 = ${DateTime.now().millisecondsSinceEpoch}');
    Future.delayed(Duration(seconds: 2), () {
      print(
          'Future.delayed() 03, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}');
      return 'Future.delayed() 03 result! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}';
    }).then((val) => print(val)).whenComplete(() => print(
        'Future.delayed() 03 whenComplete! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'));
    print('CurrentTime04 = ${DateTime.now().millisecondsSinceEpoch}');
  }

  _futureConstructor04() {
    Future.sync(() => print('Future.sync() 01'));
    Future.sync(() {
      print('Future.sync() 02');
      return 'Future.sync() 02 result!';
    }).then((val) => print(val));
    Future.sync(() {
      print('Future.sync() 03');
      return 'Future.sync() 03 result!';
    })
        .then((val) => print(val))
        .whenComplete(() => print('Future.value() 03 whenComplete!'));
  }

  _futureConstructor05() {
    Future.error(ArgumentError.notNull('Input'));
    Future.error('Future error01')
        .then((val) => print('Future.error01 result = $val'))
        .catchError((val) => print(val));
    Future.error('Future error02')
        .then((val) => print('Future.error02 result = $val'))
        .catchError((val) => print(val))
        .whenComplete(() => print('Future.error03 whenComplete!'));
  }

  _futureConstructor06() {
    Future.microtask(() => print('Future.microtask() 01'));
    Future.microtask(() {
      print('Future.microtask() 02');
      return 'Future.microtask() 02 result!';
    })
        .then((val) => print(val))
        .whenComplete(() => print('Future.microtask() 02 whenComplete!'));
    Future.microtask(() => print('Future.microtask() 03'));
  }

  _futureConstructor07() {
    Future.delayed(Duration(seconds: 3), () {
      print(
          'Future.delayed(), CurrentTime = ${DateTime.now().millisecondsSinceEpoch}');
      return 'Future.delayed() result! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}';
    })
        .timeout(Duration(seconds: 1),
            onTimeout: () =>
                'Future.delayed() TimeOut! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}')
        .then((val) => print(val))
        .whenComplete(() => print(
            'Future.delayed() whenComplete! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'));
  }

  _futureAny(index) {
    switch (index) {
      case 0:
        Future.any([
          Future.delayed(Duration(seconds: 4)).then((val) => 4),
          Future.delayed(Duration(seconds: 2)).then((val) => '2'),
          Future.delayed(Duration(seconds: 3)).then((val) => null),
        ]).then((val) => print(val));
        break;
      case 1:
        Future.any([
          Future.error(ArgumentError.notNull('Input')),
          Future.error('Future error01')
              .then((val) => print('Future.error01 result = $val'))
              .catchError((val) => print(val)),
          Future.error('Future error02')
              .then((val) => print('Future.error02 result = $val'))
              .catchError((val) => print(val))
              .whenComplete(() => print('Future.error03 whenComplete!'))
        ])
            .then((val) => print('Future.any() --> then()'))
            .catchError(
                (val) => print('Future.any() --> catchError() --> $val'))
            .whenComplete(() => print('Future.any() whenComplete!'));
        break;
      case 2:
        Future.any([
          Future.delayed(Duration(seconds: 3), () {
            print(
                'Future.delayed() 01, CurrentTime01 = ${DateTime.now().millisecondsSinceEpoch}');
            return 'Future delayed()01, CurrentTime02 = ${DateTime.now().millisecondsSinceEpoch}';
          }),
          Future.delayed(Duration(seconds: 1), () {
            print(
                'Future.delayed() 02, CurrentTime01 = ${DateTime.now().millisecondsSinceEpoch}');
            return 'Future delayed()02, CurrentTime02 = ${DateTime.now().millisecondsSinceEpoch}';
          }).then((val) {
            print(val);
            return val;
          }),
          Future.delayed(Duration(seconds: 2), () {
            print(
                'Future.delayed() 03, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}');
            return 'Future.delayed() 03 result! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}';
          }).then((val) {
            print(val);
            return val;
          }).whenComplete(() => print(
              'Future.delayed() 03 whenComplete! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'))
        ])
            .then((val) => print('Future.any() --> then() --> $val'))
            .catchError((val) => print(val))
            .whenComplete(() => print('Future.any() whenComplete!'));
        break;
    }
  }

  _futureDoWhile() {
    var i = 0;
    Future.doWhile(() {
      ++i;
      return Future.delayed(Duration(seconds: 2), () {
        print(
            'Future.doWhile() $i, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}');
        return i < 6;
      }).then((val) {
        print(val);
        return val;
      });
    })
        .then((val) => print('Future.doWhile -> then() -> $val'))
        .whenComplete(() => print('Future.doWhile -> whenComplete()'));
  }

  _futureForEach() {
    Future.forEach([
      1,
      Future(() => print('Future.forEach() 01')),
      Future(() {
        print('Future.forEach() 02');
        return 'Future.forEach() 02 result!';
      }).then((val) => print(val)),
      'Hello Flutter!',
      Future(() {
        print('Future.forEach() 03');
        return 'Future.forEach() 03 result!';
      })
          .then((val) => print(val))
          .whenComplete(() => print('Future.forEach() 03 whenComplete!'))
    ], (val) => print(val))
        .then((val) => print('Future.forEach() -> then() -> $val'))
        .whenComplete(() => print('Future.forEach() -> whenComplete()'));
  }

  _futureWait(index) {
    switch (index) {
      case 1:
        Future.wait([
          Future.delayed(Duration(seconds: 4)).then((val) {
            print('Future -> 4');
            return 4;
          }).whenComplete(() => print('Future -> 4 whenComplete!')),
          Future.delayed(Duration(seconds: 2)).then((val) {
            print('Future -> 2.toString()');
            return '2';
          }).whenComplete(() => print('Future -> 2.toString() whenComplete!')),
          Future.delayed(Duration(seconds: 3)).then((val) {
            print('Future -> null');
            return null;
          }).whenComplete(() => print('Future -> null whenComplete!')),
        ])
            .then((val) => print(val))
            .catchError(
                (val) => print('Future.wait() --> catchError() --> $val'))
            .whenComplete(() => print('Future.wait() whenComplete!'));
        break;
      case 2:
      case 3:
        Future.wait([
          Future.delayed(Duration(seconds: 4)).then((val) {
            print('Future -> 4');
            return 4;
          }).whenComplete(() => print('Future -> 4 whenComplete!')),
          Future.error('Future error01')
              .then((val) => print('Future.error01 result = $val'))
              .catchError((val) => print(val)),
          Future.error(ArgumentError.notNull('Input')),
          Future.error('Future error02')
              .then((val) => print('Future.error02 result = $val'))
              .catchError((val) => print(val))
              .whenComplete(() => print('Future.error02 whenComplete!'))
        ], eagerError: index == 2 ? false : true)
            .then((val) => print('Future.wait() --> then()'))
            .catchError(
                (val) => print('Future.wait() --> catchError() --> $val'))
            .whenComplete(() => print('Future.wait() whenComplete!'));
        break;
      case 4:
        Future.wait([
          Future.delayed(Duration(seconds: 4)).then((val) {
            print('Future -> 4');
            return 4;
          }).whenComplete(() => print('Future -> 4 whenComplete!')),
          Future.error('Future error01')
              .then((val) => print('Future.error01 result = $val'))
              .catchError((val) => print(val)),
          Future.error(ArgumentError.notNull('Input')),
          Future.delayed(Duration(seconds: 2)).then((val) {
            print('Future -> 2.toString()');
            return '2';
          }),
          Future.error('Future error02')
              .then((val) => print('Future.error02 result = $val'))
              .catchError((val) => print(val))
              .whenComplete(() => print('Future.error02 whenComplete!')),
        ], cleanUp: (val) => print('Future.wait() --> cleanUp --> $val'))
            .then((val) => print('Future.wait() --> then()'))
            .catchError(
                (val) => print('Future.wait() --> catchError() --> $val'))
            .whenComplete(() => print('Future.wait() whenComplete!'));
        break;
    }
  }

  _futureMoreThen() {
    Future.delayed(Duration(seconds: 3), () {
      return 'Future.delayed 3s!';
    }).then((val) {
      print('Future -> then(1) -> $val');
      return 'then 1';
    }).then((val) {
      print('Future -> then(2) -> $val');
      return 'then 2';
    }).then((val) {
      print('Future -> then(3) -> $val');
      return 'then 3';
    }).whenComplete(() => print('Future whenComplete!'));
  }

  _futureMoreThen02() {
    Future.delayed(Duration(seconds: 3), () {
      return 'Future.delayed 3s!';
    }).then((val) {
      print('Future -> then(1) -> $val');
      return Future.delayed(Duration(seconds: 2), () {
        return 'Future.delayed 2s!';
      }).then((val) {
        print('Future -> then(2) -> $val');
        return Future.delayed(Duration(seconds: 2), () {
          return 'Future.delayed 2s!';
        }).then((val) {
          print('Future -> then(3) -> $val');
        });
      });
    }).whenComplete(() => print('Future whenComplete!'));
  }
}
