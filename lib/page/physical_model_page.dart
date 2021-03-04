import 'package:flutter/material.dart';
import 'dart:math';

class PhysicalModelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhysicalModelPageState();
}

class _PhysicalModelPageState extends State<PhysicalModelPage> {
  bool _isClick = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('PhysicalModel Page')),
            body: ListView(children: <Widget>[
              SizedBox(height: 20.0),
              _itemText('Container.BoxDecoration'),
              Padding(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[_itemWid01(false), _itemWid01(true)]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0)),
              _itemText('ClipRRect & ClipOval'),
              Padding(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[_itemWid02(), _itemWid03()]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0)),
              _itemText('PhysicalModel'),
              Padding(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[_itemWid04(false), _itemWid04(true)]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0)),
              Padding(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[_itemWid07(false), _itemWid07(true)]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _itemText('ClipPath'),
                    _itemText('PhysicalShape')
                  ]),
              Padding(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[_itemWid05(), _itemWid06()]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0))
            ])));
  }

  _itemText(title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red, fontSize: 18.0));
  }

  _itemWid01(isCircle) {
    return Container(
        width: 80.0,
        height: 80.0,
        child: Image.asset('images/icon_hzw01.jpg'),
        decoration: isCircle
            ? BoxDecoration(
                border: Border.all(color: Colors.red, width: 5.0),
                color: Colors.grey,
                shape: BoxShape.circle)
            : BoxDecoration(
                border: Border.all(color: Colors.red, width: 5.0),
                color: Colors.grey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20.0)));
  }

  _itemWid02() {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Container(
            width: 80.0,
            height: 80.0,
            child: Image.asset('images/icon_hzw01.jpg')));
  }

  _itemWid03() {
    return Container(
        width: 80.0,
        height: 80.0,
        child: ClipOval(
            child: Image.asset('images/icon_hzw01.jpg', fit: BoxFit.fill)));
  }

  _itemWid04(isCircle) {
    return PhysicalModel(
        color: Colors.transparent,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Container(
            width: 80.0,
            height: 80.0,
            child: Image.asset('images/icon_hzw01.jpg')));
  }

  _itemWid05() {
    return ClipPath(
        clipBehavior: Clip.antiAlias,
        clipper: PolygonClipper(10),
        child: Container(
            width: 80.0,
            height: 80.0,
            child: Image.asset('images/icon_hzw01.jpg')));
  }

  _itemWid06() {
    return PhysicalShape(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        clipper: PolygonClipper(10),
        shadowColor: Colors.deepOrange,
        elevation: 6.0,
        child: Container(
            width: 80.0,
            height: 80.0,
            child: Image.asset('images/icon_hzw01.jpg')));
  }

  _itemWid07(isCircle) {
    return PhysicalModel(
        color: Colors.teal.withOpacity(0.6),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        shadowColor: isCircle ? Colors.yellow : Colors.deepOrange,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Container(
            width: 80.0, height: 80.0, color: Colors.pink.withOpacity(0.2)));
  }

  _itemAnimatedWid() {
    return AnimatedPhysicalModel(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        elevation: _isClick ? 6.0 : 0.0,
        shape: BoxShape.rectangle,
        shadowColor: Colors.black,
        color: Colors.white,
        borderRadius: _isClick
            ? BorderRadius.all(Radius.circular(10.0))
            : BorderRadius.all(Radius.circular(0.0)),
        child: Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: FlutterLogo(size: 60)));
  }
}

class PolygonClipper extends CustomClipper<Path> {
  final int num;

  PolygonClipper(this.num);

  @override
  Path getClip(Size size) {
    double radius = size.width * 0.5;
    Path _path = Path();
    var startX = size.width * 0.5 + radius * cos(2 * pi * 0 / num);
    var startY = size.height * 0.5 + radius * sin(2 * pi * 0 / num);
    _path.moveTo(startX, startY);
    for (var i = 1; i <= num; i++) {
      var newX = size.width * 0.5 + radius * cos(2 * pi * i / num);
      var newY = size.height * 0.5 + radius * sin(2 * pi * i / num);
      _path.lineTo(newX, newY);
    }
    _path.close();
    return _path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
