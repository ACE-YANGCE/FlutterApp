import 'package:flutter/material.dart';
import 'package:flutter_app/utils/common_line_painter.dart';
import 'package:flutter_app/utils/screen_utils.dart';

class AnimatedBuilderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedBuilderPageState();
}

class _AnimatedBuilderPageState extends State<AnimatedBuilderPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(children: <Widget>[
      Container(
          width: ScreenUtils.getScreenWidth(),
          height: ScreenUtils.getScreenHeight(),
          child: CustomPaint(painter: CommonLinePainter(context, 50.0))),
      TopMenuWidget(controller: _controller),
      _animatedWid(),
      Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _itemWid('Transform.translate', 0, Colors.green.withOpacity(0.8)),
        SizedBox(height: 20.0),
        _itemWid(
            'AnimationController.reverse', 1, Colors.blue.withOpacity(0.8)),
        SizedBox(height: 20.0),
        _itemWid('Hide Menu', 2, Colors.brown.withOpacity(0.8))
      ]))
    ])));
  }

  _animatedWid() {
    return AnimatedBuilder(
        animation: _controller,
        child: Container(
            color: Colors.brown,
            height: 100.0,
            width: 300.0,
            child: Center(
                child: GestureDetector(
                    onTap: () => print('I am form AnimatedBuilder !'),
                    child: Icon(Icons.ac_unit, color: Colors.white)))),
        builder: (BuildContext context, Widget child) {
          return Transform.translate(
              offset: Offset(
                  50, ScreenUtils.getScreenHeight() - _controller.value * 200),
              child: Opacity(opacity: _controller.value, child: child));
        });
  }

  _itemWid(text, index, color) {
    return Center(
        child: FlatButton(
            onPressed: () => _itemClick(index),
            child: Text(text, style: TextStyle(color: Colors.white)),
            color: color));
  }

  _itemClick(index) {
    switch (index) {
      case 0:
        setState(() {});
        _controller.reset();
        _controller.forward();
        break;
      case 1:
        setState(() {});
        _controller.reverse();
        break;
      case 2:
        setState(() {});
        _controller.reset();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          print("Current status is dismissed !");
          break;
        case AnimationStatus.forward:
          print("Current status is forward !");
          break;
        case AnimationStatus.reverse:
          print("Current status is reverse !");
          break;
        case AnimationStatus.completed:
          print("Current status is completed !");
          break;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TopMenuWidget extends AnimatedWidget {
  const TopMenuWidget({Key key, AnimationController controller})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
//    return Transform.scale(
//        scale: _progress.value,
//        origin: Offset(50, 50),
//        alignment: Alignment.center,
//        child: Container(
//            width: 200.0,
//            height: 200.0,
//            color: Colors.yellow.withOpacity(0.8)));
    return Transform.translate(
        offset: Offset(50, 100 * _progress.value),
        child: Opacity(
            opacity: _progress.value,
            child: Container(
                width: 300.0,
                height: 100.0,
                color: Colors.yellow,
                child: Center(
                    child: GestureDetector(
                        onTap: () => print('I am from AnimatedWidget !'),
                        child: Icon(Icons.ac_unit, color: Colors.white))))));
  }
}
