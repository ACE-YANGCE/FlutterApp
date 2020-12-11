import 'package:flutter/material.dart';
import 'package:flutter_app/utils/common_line_painter.dart';
import 'package:flutter_app/widget/ace_page_menu.dart';

class ACEPageMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEPageMenuPageState();
}

class _ACEPageMenuPageState extends State<ACEPageMenuPage>
    with SingleTickerProviderStateMixin {
  bool _isShowTopMenu = false,
      _isShowBottomMenu = false,
      _isShowLeftMenu = false,
      _isShowRightMenu = false,
      _isShowMixMenu = false;
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(painter: CommonLinePainter(context, 50.0))),
      ACEPageMenu(_controller, _isShowTopMenu, _isShowBottomMenu,
          _isShowLeftMenu, _isShowRightMenu, _isShowMixMenu),
      Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _itemWid('Show TopMenu', 0, Colors.green.withOpacity(0.8)),
        SizedBox(height: 20.0),
        _itemWid('Show BottomMenu', 1, Colors.blue.withOpacity(0.8)),
        SizedBox(height: 20.0),
        _itemWid('Show LeftMenu', 2, Colors.pink.withOpacity(0.8)),
        SizedBox(height: 20.0),
        _itemWid('Show RightMenu', 3, Colors.deepPurpleAccent.withOpacity(0.8)),
        SizedBox(height: 20.0),
        _itemWid(
            'Show TopMenu && BottomMenu', 4, Colors.yellow.withOpacity(0.8)),
        SizedBox(height: 20.0),
        _itemWid('Hide Menu', 5, Colors.brown.withOpacity(0.8))
      ]))
    ])));
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
        setState(() {
          _isShowTopMenu = true;
          _isShowBottomMenu = false;
          _isShowLeftMenu = false;
          _isShowMixMenu = false;
          _isShowRightMenu = false;
        });
        _controller.reset();
        _controller.forward();
        break;
      case 1:
        setState(() {
          _isShowBottomMenu = true;
          _isShowTopMenu = false;
          _isShowLeftMenu = false;
          _isShowMixMenu = false;
          _isShowRightMenu = false;
        });
        _controller.reset();
        _controller.forward();
        break;
      case 2:
        setState(() {
          _isShowLeftMenu = true;
          _isShowTopMenu = false;
          _isShowBottomMenu = false;
          _isShowMixMenu = false;
          _isShowRightMenu = false;
        });
        _controller.reset();
        _controller.forward();
        break;
      case 3:
        setState(() {
          _isShowRightMenu = true;
          _isShowTopMenu = false;
          _isShowBottomMenu = false;
          _isShowLeftMenu = false;
          _isShowMixMenu = false;
        });
        _controller.reset();
        _controller.forward();
        break;
      case 4:
        setState(() {
          _isShowMixMenu = true;
          _isShowTopMenu = false;
          _isShowBottomMenu = false;
          _isShowLeftMenu = false;
          _isShowRightMenu = false;
        });
        _controller.reset();
        _controller.forward();
        break;
      case 5:
        setState(() {
          _isShowTopMenu = false;
          _isShowBottomMenu = false;
          _isShowLeftMenu = false;
          _isShowMixMenu = false;
          _isShowRightMenu = false;
        });
        _controller.reset();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
