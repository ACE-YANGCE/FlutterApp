import 'package:flutter/material.dart';
import 'package:flutter_app/menu/menu_enum.dart';
import 'package:flutter_app/menu/menu_gesture_recognizer.dart';
import 'package:flutter_app/utils/common_line_painter.dart';
import 'package:flutter_app/utils/screen_utils.dart';
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
  bool _isGestureSlide = false, _isMenuShow = false;
  MenuBottomType _bottomType = MenuBottomType.MENU_BOTTOM_COMMON;
  AnimationController _controller;
  double _slideValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(children: <Widget>[
      Container(
          width: ScreenUtils.getScreenWidth(),
          height: ScreenUtils.getScreenHeight(),
          child: RawGestureDetector(
              child: CustomPaint(painter: CommonLinePainter(context, 50.0)),
              gestures: <Type, GestureRecognizerFactory>{
                MenuGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<MenuGestureRecognizer>(
                        () => MenuGestureRecognizer(),
                        (MenuGestureRecognizer gesture) {
                  gesture.onDown = (detail) {
                    print('---MenuGestureRecognizer.onDown---$detail');
                  };
                  gesture.onUpdate = (detail) {
                    _isGestureSlide = true;
                    print('---MenuGestureRecognizer'
                        '.onUpdate---$detail---${detail.localPosition}');
                  };
                  gesture.onEnd = (detail) {
                    if (!_isGestureSlide) {
                      _menuState(_isMenuShow
                          ? MenuType.MENU_CLOSE
                          : MenuType.MENU_MIX);
                      _isMenuShow = !_isMenuShow;
                    }
                    _isGestureSlide = false;
                    print('---MenuGestureRecognizer'
                        '.onEnd---$detail---${detail.primaryVelocity}---${detail.velocity}---${detail.velocity.pixelsPerSecond}');
                  };
//                  gesture
//                    ..onDown = (detail) {
//                      print('---MenuGestureRecognizer.onDown---$detail');
//                      _itemClick(4);
//                    };
//                  gesture
//                    ..onUpdate = (detail) {
//                      print('---MenuGestureRecognizer'
//                          '.onUpdate---$detail---${detail.localPosition}');
//                    };
//                  gesture
//                    ..onEnd = (detail) {
//                      print('---MenuGestureRecognizer.onEnd---$detail');
//                    };
                })
              })),
//      ListView(children: <Widget>[
//        SizedBox(height: 100),
//        Slider(
//            min: 1,
//            max: 100,
//            divisions: 100,
//            activeColor: Colors.green,
//            inactiveColor: Colors.grey,
//            value: _slideValue,
//            onChanged: (val) {
//              setState(() => _slideValue = val);
//            }),
//        _itemWid('Show TopMenu', 0, Colors.green.withOpacity(0.8)),
//        SizedBox(height: 20.0),
//        _itemWid('Show BottomMenu', 1, Colors.blue.withOpacity(0.8)),
//        SizedBox(height: 20.0),
//        _itemWid('Show LeftMenu', 2, Colors.pink.withOpacity(0.8)),
//        SizedBox(height: 20.0),
//        _itemWid('Show RightMenu', 3, Colors.deepPurpleAccent.withOpacity(0.8)),
//        SizedBox(height: 20.0),
//        _itemWid(
//            'Show TopMenu && BottomMenu', 4, Colors.yellow.withOpacity(0.8)),
//        SizedBox(height: 20.0),
//        _itemWid('Hide Menu', 5, Colors.brown.withOpacity(0.8))
//      ]),
      ACEPageMenu(
          _controller,
          _isShowTopMenu,
          _isShowBottomMenu,
          _isShowLeftMenu,
          _isShowRightMenu,
          _isShowMixMenu,
          _bottomType,
          (type, data) => _itemMenuClick(type, data))
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
          _bottomType = MenuBottomType.MENU_BOTTOM_COMMON;
        });
        _controller.reset();
        break;
    }
  }

  _menuState(type) {
    switch (type) {
      case MenuType.MENU_TOP:
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
      case MenuType.MENU_BOTTOM:
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
      case MenuType.MENU_LEFT:
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
      case MenuType.MENU_RIGHT:
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
      case MenuType.MENU_MIX:
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
      case MenuType.MENU_CLOSE:
        setState(() {
          _isShowTopMenu = false;
          _isShowBottomMenu = false;
          _isShowLeftMenu = false;
          _isShowMixMenu = false;
          _isShowRightMenu = false;
          _bottomType = MenuBottomType.MENU_BOTTOM_COMMON;
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

  _itemMenuClick(type, data) {
    switch (type) {
      case MenuItemType.MENU_BACK:
        print('ACEPageTopMenu -- MenuItemType.MENU_BACK----');
        break;
      case MenuItemType.MENU_DOWNLOAD:
        print('ACEPageTopMenu -- MenuItemType.MENU_DOWNLOAD----');
        break;
      case MenuItemType.MENU_MORE:
        print('ACEPageTopMenu -- MenuItemType.MENU_MORE----');
        break;
      case MenuItemType.MENU_SETTING:
        print('ACEPageBottomMenu -- MenuItemType.MENU_SETTING---');
        setState(() {
          _isShowBottomMenu = true;
          _isShowTopMenu = false;
          _isShowLeftMenu = false;
          _isShowMixMenu = false;
          _isShowRightMenu = false;
          _bottomType = MenuBottomType.MENU_BOTTOM_SHARE;
        });
        _controller.reset();
        _controller.forward();
        break;
      case MenuItemType.MENU_PRE_CHAPTER:
        print('ACEPageBottomMenu -- MenuItemType.MENU_PRE_CHAPTER:');
        break;
      case MenuItemType.MENU_NEXT_CHAPTER:
        print('ACEPageBottomMenu -- MenuItemType.MENU_NEXT_CHAPTER');
        break;
      case MenuItemType.MENU_CATALOG:
        print('ACEPageBottomMenu -- MenuItemType.MENU_CATALOG');
        _menuState(MenuType.MENU_LEFT);
        break;
      case MenuItemType.MENU_LIGHT_MODE:
        print('ACEPageBottomMenu -- MenuItemType.MENU_LIGHT_MODE');
        break;
      case MenuItemType.MENU_NIGHT_MODE:
        print('ACEPageBottomMenu -- MenuItemType.MENU_NIGHT_MODE');
        break;
      case MenuItemType.MENU_QQ:
        print('ACEPageBottomMenu -- MenuItemType.MENU_QQ');
        break;
      case MenuItemType.MENU_QZONE:
        print('ACEPageBottomMenu -- MenuItemType.MENU_QZONE');
        break;
      case MenuItemType.MENU_WECHAT:
        print('ACEPageBottomMenu -- MenuItemType.MENU_WECHAT');
        break;
      case MenuItemType.MENU_WECHAT_MOMENT:
        print('ACEPageBottomMenu -- MenuItemType.MENU_WECHAT_MOMENT');
        break;
      case MenuItemType.MENU_CLOSE:
        print('ACEPageBottomMenu -- MenuItemType.MENU_CLOSE');
        _menuState(MenuType.MENU_CLOSE);
        break;
      case MenuItemType.MENU_LEFT_CATALOG:
        print('ACEPageLeftMenu -- MenuItemType.MENU_LEFT_CATALOG');
        break;
      case MenuItemType.MENU_LEFT_TAG:
        print('ACEPageLeftMenu -- MenuItemType.MENU_LEFT_TAG');
        break;
      case MenuItemType.MENU_LEFT_CATALOG_ITEM:
        print(
            'ACEPageLeftMenu -- MenuItemType.MENU_LEFT_CATALOG_ITEM -- $data');
        break;
    }
  }
}
