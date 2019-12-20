import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedCrossFadePage extends StatefulWidget {
  @override
  _AnimatedCrossFadeState createState() => new _AnimatedCrossFadeState();
}

class _AnimatedCrossFadeState extends State<AnimatedCrossFadePage>
    with TickerProviderStateMixin {
  var isChanged = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('AnimatedCrossFadePage')),
            body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(height: 150, child: _itemWid01()),
              SizedBox(height: 4),
              SizedBox(height: 150, child: _itemWid02()),
              SizedBox(height: 4),
              _itemWid03()
            ])));
  }

  Widget _itemWid01() {
    return GestureDetector(
        onTap: () {
          setState(() => isChanged = !isChanged);
        },
        child: Container(
            child: AnimatedCrossFade(
                firstChild: Container(
                    width: 250,
                    height: 150,
                    color: Colors.purpleAccent.withOpacity(0.4)),
                secondChild: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blueGrey.withOpacity(0.4)),
                duration: Duration(milliseconds: 1500),
                firstCurve: Curves.fastOutSlowIn,
                secondCurve: Curves.easeInExpo,
                sizeCurve: Curves.easeInExpo,
                alignment: Alignment.bottomRight,
                crossFadeState: isChanged
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst)));
  }

  Widget _itemWid03() {
    return GestureDetector(
        onTap: () {
          setState(() {
            isChanged = !isChanged;
          });
        },
        child: Container(
            child: AnimatedCrossFade(
                firstChild: Container(
                    width: 250,
                    height: 150,
                    color: Colors.purpleAccent.withOpacity(0.4)),
                secondChild: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blueGrey.withOpacity(0.4)),
                duration: Duration(milliseconds: 1500),
                reverseDuration: Duration(milliseconds: 8500),
                firstCurve: Curves.fastOutSlowIn,
                secondCurve: Curves.easeInExpo,
                sizeCurve: Curves.fastOutSlowIn,
                alignment: Alignment.center,
                crossFadeState: isChanged
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst)));
  }

  Widget _itemWid02() {
    return AnimatedCrossFade(
        firstChild: Container(
            width: 250,
            height: 150,
            color: Colors.purpleAccent.withOpacity(0.4)),
        secondChild: Container(
            width: 100, height: 100, color: Colors.blueGrey.withOpacity(0.4)),
        duration: Duration(milliseconds: 1500),
        crossFadeState:
            !isChanged ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(children: <Widget>[
            Positioned(
                key: bottomChildKey,
                left: 50.0,
                top: 50.0,
                right: 50.0,
                bottom: 50.0,
                child: bottomChild),
            Positioned(key: topChildKey, child: topChild)
          ]);
        });
  }
}
