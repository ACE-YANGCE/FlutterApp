import 'package:flutter/material.dart';
import 'dart:math';

class MathPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MathPageState();
}

class _MathPageState extends State<MathPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Math Page')),
        body: ListView(children: <Widget>[
          _itemConstants(0, Colors.teal.withOpacity(0.4)),
          _itemConstants(1, Colors.amber.withOpacity(0.4)),
          _itemConstants(2, Colors.brown.withOpacity(0.4)),
          _itemConstants(3, Colors.blue.withOpacity(0.4)),
          _itemConstants(4, Colors.blueGrey.withOpacity(0.4)),
          _itemConstants(5, Colors.indigo.withOpacity(0.4)),
          _itemConstants(6, Colors.deepOrange.withOpacity(0.4)),
          _itemConstants(7, Colors.cyan.withOpacity(0.4)),
          _itemConstants(8, Colors.teal.withOpacity(0.4)),
          _itemConstants(9, Colors.amber.withOpacity(0.4)),
          _itemConstants(10, Colors.brown.withOpacity(0.4)),
          _itemConstants(11, Colors.blue.withOpacity(0.4)),
          _itemConstants(12, Colors.blueGrey.withOpacity(0.4)),
          _itemConstants(13, Colors.indigo.withOpacity(0.4)),
          _itemConstants(14, Colors.deepOrange.withOpacity(0.4)),
          _itemConstants(15, Colors.cyan.withOpacity(0.4)),
          _itemConstants(16, Colors.teal.withOpacity(0.4)),
          _itemConstants(17, Colors.amber.withOpacity(0.4)),
          _itemConstants(18, Colors.brown.withOpacity(0.4)),
          _itemConstants(19, Colors.blue.withOpacity(0.4))
        ]));
  }

  _itemConstants(index, color) {
    var _text = '';
    switch (index) {
      case 0:
        _text = 'e -> $e';
        break;
      case 1:
        _text = 'ln10 -> $ln10';
        break;
      case 2:
        _text = 'ln2 -> $ln2';
        break;
      case 3:
        _text = 'log2e -> $log2e';
        break;
      case 4:
        _text = 'log10e -> $log10e';
        break;
      case 5:
        _text = 'pi -> $pi';
        break;
      case 6:
        _text = 'sqrt2 -> $sqrt2';
        break;
      case 7:
        _text = 'sqrt1_2 -> $sqrt1_2';
        break;
      case 8:
        _text =
            'min(-1, 2) -> ${min(-1, 2)} \nmin(-0.0, 0.0) -> ${min(-0.0, 0.0)} \nmin(2, 2.0) -> ${min(2, 2.0)}';
        break;
      case 9:
        _text =
            'max(-1, 2) -> ${max(-1, 2)} \nmax(-0.0, 0.0) -> ${max(-0.0, 0.0)} \nmax(2, 2.0) -> ${max(2, 2.0)}';
        break;
      case 10:
        _text =
            'sqrt(-1) -> ${sqrt(-1)} \nsqrt(-0.0) -> ${sqrt(-0.0)} \nsqrt(pi) -> ${sqrt(pi)}';
        break;
      case 11:
        _text =
            'exp(-1) -> ${exp(-1)} \nexp(-0.0) -> ${exp(-0.0)} \nexp(pi) -> ${exp(pi)}';
        break;
      case 12:
        _text =
            'log(-1) -> ${log(-1)} \nlog(-0.0) -> ${log(-0.0)} \nlog(pi) -> ${log(pi)}';
        break;
      case 13:
        _text =
            'pow(-1, 2) -> ${pow(-1, 2)} \npow(-0.0, 0.0) -> ${pow(-0.0, 0.0)} \npow(2, 2.0) -> ${pow(2, 2.0)}';
        break;
      case 14:
        _text =
            'sin(pi / 2) -> ${sin(pi / 2)} \nsin(pi / 3) -> ${sin(pi / 3)}\nsin(pi / 4) -> ${sin(pi / 4)}';
        break;
      case 15:
        _text =
            'cos(pi / 2) -> ${cos(pi / 2)} \ncos(pi / 3) -> ${cos(pi / 3)}\ncos(pi / 4) -> ${cos(pi / 4)}';
        break;
      case 16:
        _text =
            'tan(pi / 2) -> ${tan(pi / 2)} \ntan(pi / 3) -> ${tan(pi / 3)}\ntan(pi / 4) -> ${tan(pi / 4)}';
        break;
      case 17:
        _text =
            'asin(1.0) -> ${asin(1.0)} \nasin(0.866) -> ${asin(0.866)}\nasin(0.707) -> ${asin(0.707)}';
        break;
      case 18:
        _text =
            'acos(1.0) -> ${acos(1.0)} \nacos(0.5) -> ${acos(0.5)}\nacos(0.707) -> ${acos(0.707)}';
        break;
      case 19:
        _text = 'atan(1.0) -> ${atan(1.0)} \natan(1.73) -> ${atan(1.73)}';
        break;
    }
    return Container(
        height: index >= 8 ? 100 : 70,
        color: color,
        child: Center(
            child: Text(_text,
                style: TextStyle(color: Colors.white, fontSize: 16))));
  }
}
