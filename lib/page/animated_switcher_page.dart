import 'package:flutter/material.dart';

class AnimatedSwitcherPage extends StatefulWidget {
  @override
  _AnimatedSwitcherState createState() => new _AnimatedSwitcherState();
}

class _AnimatedSwitcherState extends State<AnimatedSwitcherPage>
    with TickerProviderStateMixin {
  var isChanged = false;
  var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('AnimatedSwitcherPage')),
            body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(height: 140, child: Center(child: _itemWid01())),
              SizedBox(height: 4),
              _itemWid02(),
//              SizedBox(height: 140, child: _itemWid02()),
              SizedBox(height: 4),
              Container(height: 160, child: Center(child: _itemWid03())),
            ])));
  }

  Widget _itemWid01() {
    return GestureDetector(
        onTap: () => setState(() => isChanged = !isChanged),
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 1500),
            switchInCurve: Curves.easeInCubic,
            switchOutCurve: Curves.fastLinearToSlowEaseIn,
            child: isChanged
                ? Container(
                    key: UniqueKey(),
                    color: Colors.purpleAccent.withOpacity(0.4),
                    width: 100,
                    height: 100)
                : Container(
                    key: UniqueKey(),
                    color: Colors.green.withOpacity(0.4),
                    width: 150,
                    height: 120),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            layoutBuilder:
                (Widget currentChild, List<Widget> previousChildren) {
              return Stack(children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild
              ], alignment: Alignment.bottomRight);
            }));
  }

  Widget _itemWid02() {
    return GestureDetector(
        onTap: () => setState(() => isChanged = !isChanged),
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            reverseDuration: Duration(milliseconds: 1500),
            switchInCurve: Curves.easeInExpo,
            switchOutCurve: Curves.fastOutSlowIn,
            child: isChanged
                ? Container(
                    key: UniqueKey(),
                    color: Colors.purpleAccent.withOpacity(0.4),
                    width: 100,
                    height: 100)
                : Container(
                    key: UniqueKey(),
                    color: Colors.green.withOpacity(0.4),
                    width: 150,
                    height: 120),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                  child: child,
                  position:
                      Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                          .animate(animation));
            },
            layoutBuilder:
                (Widget currentChild, List<Widget> previousChildren) {
              return currentChild;
            }));
  }

  Widget _itemWid03() {
    return GestureDetector(
        onTap: () => setState(() {
              ++index;
              index = index % 3;
            }),
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _animatedItemWid(index),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                  child: child,
                  position:
                      Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                          .animate(animation));
            }));
  }

  Widget _animatedItemWid(index) {
    switch (index) {
      case 0:
        return Container(
            key: UniqueKey(),
            color: Colors.purpleAccent.withOpacity(0.4),
            width: 100,
            height: 100);
        break;
      case 1:
        return Container(
            key: UniqueKey(),
            color: Colors.green.withOpacity(0.4),
            width: 150,
            height: 120);
        break;
      case 2:
        return Container(
            key: UniqueKey(),
            color: Colors.orange.withOpacity(0.4),
            width: 120,
            height: 140);
        break;
    }
  }
}
