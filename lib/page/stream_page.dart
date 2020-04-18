import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  @override
  _StreamPageState createState() => new _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Stream Page')),
        body: ListView(children: <Widget>[
          _itemWid(
              'Single-Subscription 监听两次', 12, Colors.green.withOpacity(0.7)),
          _itemWid('Single-BroadCast 监听两次', 13, Colors.red.withOpacity(0.7)),
          _itemWid('Stream Controller', 14, Colors.grey.withOpacity(0.7)),
          SizedBox(height: 50),
          _itemWid('Stream.fromFuture(Future<T> future)', 0,
              Colors.green.withOpacity(0.7)),
          _itemWid('Stream.fromFutures(Iterable<Future<T>> futures)', 1,
              Colors.red.withOpacity(0.7)),
          _itemWid('Stream.fromIterable(Iterable<T> elements)', 2,
              Colors.orange.withOpacity(0.7)),
          _itemWid(
              'Stream.periodic(Duration period,[T computation(int '
              'computationCount)])',
              3,
              Colors.grey.withOpacity(0.7)),
          _itemWid('Stream.length', 4, Colors.blue.withOpacity(0.7)),
          _itemWid('Stream.isEmpty', 5, Colors.purpleAccent.withOpacity(0.7)),
          _itemWid('Stream.isBroadcast', 6, Colors.pinkAccent.withOpacity(0.7)),
          _itemWid('Stream.first', 7, Colors.deepPurple.withOpacity(0.7)),
          _itemWid('Stream.last', 8, Colors.blueGrey.withOpacity(0.7)),
          _itemWid('Stream.toList()', 9, Colors.amber.withOpacity(0.7)),
          _itemWid('Stream.toSet()', 10, Colors.cyan.withOpacity(0.7)),
          _itemWid(
              'Stream.forEach()', 11, Colors.indigoAccent.withOpacity(0.7)),
        ]));
  }

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 3));
    return '当前时间为：${DateTime.now()}';
  }

  _streamFromIterable2(isBroadcast) {
    var data = [1, 2, '3.toString()', true, true, false, true, 6];
    Stream stream = Stream.fromIterable(data).distinct();
    if (isBroadcast) {
      stream = stream.asBroadcastStream();
    }
    stream
        .listen((event) => print('Liste1 -> Stream.fromIterable -> $event'))
        .onDone(() => print('onDone1 -> Stream.fromIterable -> done 结束'));
    stream
        .listen((event2) => print('Liste2 -> Stream.fromIterable -> $event2'))
        .onDone(() => print('onDone2 -> Stream.fromIterable -> done 结束'));
  }

  _streamController(isBroadcast) {
    var data = [1, 2, '3.toString()', true, true, false, true, 6];
    var controller = StreamController();
    for (int i = 0; i < data.length; i++) {
      controller.sink.add(data[i]);
    }
    Stream stream = controller.stream.distinct().asBroadcastStream();
    stream
        .listen((event) => print('Liste1 -> Stream.fromIterable -> $event'))
        .onDone(() => print('onDone1 -> Stream.fromIterable -> done 结束'));
    stream
        .listen((event) => print('Liste2 -> Stream.fromIterable -> $event'))
        .onDone(() => print('onDone2 -> Stream.fromIterable -> done 结束'));
    controller.close();
  }

  _streamFromFuture() {
    Stream.fromFuture(getData())
        .listen((event) => print('Stream.fromFuture -> $event'))
        .onDone(() => print('Stream.fromFuture -> done 结束'));
  }

  _streamFromFutures() {
    var data = [getData(), getData(), getData()];
    Stream stream = Stream.fromFutures(data);
    stream.listen((event) => print('Stream.fromFutures -> $event'),
        onDone: () => print('Stream.fromFutures -> done 结束'));
  }

  _streamFromIterable() {
    var data = [1, 2, '3.toString()', true, true, false, true, 6];
    Stream.fromIterable(data)
        .distinct()
        .listen((event) => print('Stream.fromIterable -> $event'))
        .onDone(() => print('Stream.fromIterable -> done 结束'));
  }

  _streamFromPeriodic() {
    Duration interval = Duration(seconds: 1);
//    Stream<int> stream = Stream<int>.periodic(interval);
//    stream.listen((event) {
//      print('Stream.periodic -> $event');
//    }).onDone(() {
//      print('Stream.periodic -> done 结束');
//    });

    Stream<int> streamData = Stream<int>.periodic(interval, (data) => data + 1);
    streamData.takeWhile((element) {
      print('Stream.periodic.takeWhile -> $element');
      return element <= 6;
    }).where((event) {
      print('Stream.periodic.where -> $event');
      return event > 2;
    }).skipWhile((element) {
      print('Stream.periodic.skipWhile -> $element');
      return element <= 4;
    }).map((event) {
      print('Stream.periodic.map -> $event -> ${event * 100}');
      return event * 100;
    }).expand((element) {
      print(
          'Stream.periodic.expand -> $element -> ${element * 10} -> ${element * 100}');
      return [element, element * 10, element * 100];
    }).listen((event) {
      print('Stream.periodic -> $event');
    }).onDone(() {
      print('Stream.periodic -> done 结束');
    });
  }

  _streamLength(index) async {
    Duration interval = Duration(seconds: 1);
    Stream<int> streamData = Stream<int>.periodic(interval, (data) => data + 1);
    streamData = streamData.takeWhile((element) {
      print('Stream.periodic.takeWhile -> $element');
      return element <= 6;
    }).where((event) {
      print('Stream.periodic.where -> $event');
      return event > 2;
    }).skipWhile((element) {
      print('Stream.periodic.skipWhile -> $element');
      return element <= 4;
    });
    switch (index) {
      case 1:
        var length = await streamData.length;
        print('Stream.length -> $length');
        break;
      case 2:
        var isEmpty = await streamData.isEmpty;
        print('Stream.isEmpty -> $isEmpty');
        break;
      case 3:
        var isBroadcast = await streamData.isBroadcast;
        print('Stream.isBroadcast -> $isBroadcast');
        break;
      case 4:
        var first = await streamData.first;
        print('Stream.first -> $first');
        break;
      case 5:
        var last = await streamData.last;
        print('Stream.last -> $last');
        break;
    }
  }

  _streamToList() async {
    var data = [1, 2, '3.toString()', true, true, false, true, 6];
    Stream stream = Stream.fromIterable(data).distinct();
    List list = await stream.toList();
    if (list != null) {
      print('Stream.toList -> ${list}');
      for (int i = 0; i < list.length; i++) {
        print('Stream.toList -> ${i + 1} -> ${list[i]}');
      }
    }
  }

  _streamToSet() async {
    var data = [1, 2, '3.toString()', true, true, false, true, 6];
    Stream stream = Stream.fromIterable(data);
    Set set = await stream.toSet();
    if (set != null) {
      print('Stream.toSet -> ${set}');
    }
  }

  _streamForEach() {
    var data = [1, 2, '3.toString()', true, true, false, true, 6];
    Stream stream = Stream.fromIterable(data).distinct();
    stream.forEach((element) => print('Stream.forEach -> $element'));
  }

  Widget _itemWid(text, index, color) {
    return FlatButton(
        onPressed: () => _itemClick(index),
        child: Text(text, style: TextStyle(color: Colors.white)),
        color: color);
  }

  _itemClick(index) {
    switch (index) {
      case 0:
        print('Stream.fromFuture -> start');
        _streamFromFuture();
        print('Stream.fromFuture -> end');
        break;
      case 1:
        print('Stream.fromFutures -> start');
        _streamFromFutures();
        print('Stream.fromFutures -> end');
        break;
      case 2:
        print('Stream.fromIterable -> start');
        _streamFromIterable();
        print('Stream.fromIterable -> end');
        break;
      case 3:
        print('Stream.fromIterable -> start');
        _streamFromPeriodic();
        print('Stream.fromIterable -> end');
        break;
      case 4:
        _streamLength(1);
        break;
      case 5:
        _streamLength(2);
        break;
      case 6:
        _streamLength(3);
        break;
      case 7:
        _streamLength(4);
        break;
      case 8:
        _streamLength(5);
        break;
      case 9:
        _streamToList();
        break;
      case 10:
        _streamToSet();
        break;
      case 11:
        _streamForEach();
        break;
      case 12:
        _streamFromIterable2(false);
        break;
      case 13:
        _streamFromIterable2(true);
        break;
      case 14:
        _streamController(false);
        break;
    }
  }
}
