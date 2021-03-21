import 'package:flutter/material.dart';
import 'dart:math';

class ShaderMaskPage extends StatefulWidget {
  @override
  _ShaderMaskPageState createState() => new _ShaderMaskPageState();
}

class _ShaderMaskPageState extends State<ShaderMaskPage> {
  String _paraStr = 'Flutter 是谷歌的移动UI框架，可以快速在 iOS 和 Android 上构建高质量的原生用户界面。 '
      'Flutter 可以与现有的代码一起工作。在全世界，Flutter 正在被越来越多的开发者和组织使用，并且 Flutter '
      '是完全免费、开源的。';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ShaderMask Page")),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(children: <Widget>[
              _shaderMask01(),
              SizedBox(height: 5.0),
              Divider(height: 1.0, color: Colors.blue),
              SizedBox(height: 5.0),
              _shaderMask02(),
              SizedBox(height: 5.0),
              Divider(height: 1.0, color: Colors.blue),
              SizedBox(height: 5.0),
              _rowImages01(),
              SizedBox(height: 5.0),
              _rowImages02(),
              SizedBox(height: 5.0),
              Divider(height: 1.0, color: Colors.blue),
              SizedBox(height: 5.0),
              _shaderMask05(),
              SizedBox(height: 5.0),
              Divider(height: 1.0, color: Colors.blue),
              SizedBox(height: 5.0),
              _shaderMask06(),
              SizedBox(height: 5.0),
              Divider(height: 1.0, color: Colors.blue),
              SizedBox(height: 5.0),
              _shaderMask08(),
              SizedBox(height: 5.0),
              Divider(height: 1.0, color: Colors.blue),
              SizedBox(height: 5.0),
              _shaderMask09()
            ])));
  }

  _shaderMask01() {
    return ShaderMask(
        shaderCallback: (rect) => LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepOrange.withOpacity(0.6),
                Colors.yellow,
                Colors.green
              ],
              stops: [0.2, 0.5, 0.9],
            ).createShader(rect),
        child: _itemText(_paraStr));
  }

  _shaderMask02() {
    return ShaderMask(
        shaderCallback: (rect) => LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepOrange.withOpacity(0.6),
                Colors.yellow,
                Colors.green
              ],
              stops: [0.1, 0.5, 0.9],
            ).createShader(rect),
        child: _itemText(_paraStr));
  }

  _rowImages01() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              width: 100,
              height: 100,
              child: Image.asset('images/icon_hzw01.jpg')),
          _shaderMask03(),
          _shaderMask04()
        ]);
  }

  _shaderMask03() {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [Color(0xFF704214), Colors.brown],
          ).createShader(bounds);
        },
        blendMode: BlendMode.color,
        child: Container(
            width: 100,
            height: 100,
            child: Image.asset('images/icon_hzw01.jpg')));
  }

  _shaderMask04() {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(colors: [Colors.black, Colors.white])
              .createShader(bounds);
        },
        blendMode: BlendMode.hue,
        child: Container(
            width: 100,
            height: 100,
            child: Image.asset('images/icon_hzw01.jpg')));
  }

  _itemText(str) => Text(str,
      style: TextStyle(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600));

  _shaderMask05() {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return RadialGradient(
                  center: Alignment.topLeft,
                  radius: 0.5,
                  colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
                  tileMode: TileMode.mirror)
              .createShader(bounds);
        },
        child: _itemText(_paraStr));
  }

  _shaderMask06() {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return RadialGradient(
                  center: Alignment.center,
                  radius: 0.5,
                  colors: [
                    Colors.deepOrange.withOpacity(0.6),
                    Colors.yellow,
                    Colors.green
                  ],
                  stops: [0.1, 0.5, 0.9],
                  tileMode: TileMode.mirror)
              .createShader(bounds);
        },
        child: _itemText(_paraStr));
  }

  _shaderMask07(_blendMode) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return RadialGradient(
            colors: [Colors.green, Colors.blue, Colors.orange],
            center: Alignment.center,
          ).createShader(bounds);
        },
        blendMode: _blendMode,
        child: Container(
            width: 100,
            height: 100,
            child: Image.asset('images/icon_hzw01.jpg')));
  }

  _shaderMask08() {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return SweepGradient(
            colors: [
              Colors.deepOrange.withOpacity(0.6),
              Colors.yellow,
              Colors.green
            ],
            stops: [0.3, 0.6, 0.9],
            center: Alignment.center,
          ).createShader(bounds);
        },
        child: _itemText(_paraStr));
  }

  _shaderMask09() {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return SweepGradient(
            colors: [
              Colors.deepOrange.withOpacity(0.6),
              Colors.yellow,
              Colors.green
            ],
            startAngle: pi * 0.5,
            endAngle: 2 * pi * 0.6,
            center: Alignment.center,
          ).createShader(bounds);
        },
        child: _itemText(_paraStr));
  }

  _rowImages02() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _shaderMask07(BlendMode.screen),
          _shaderMask07(BlendMode.hardLight),
          _shaderMask07(BlendMode.difference),
        ]);
  }
}
