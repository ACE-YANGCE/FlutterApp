import 'package:flutter/material.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:flutter_app/widget/ace_menu_delegate.dart';

class ACEPageMenu extends StatelessWidget {
  final bool _isShowTopMenu,
      _isShowBottomMenu,
      _isShowLeftMenu,
      _isShowRightMenu,
      _isShowMixMenu;
  final AnimationController _controller;

  ACEPageMenu(this._controller, this._isShowTopMenu, this._isShowBottomMenu,
      this._isShowLeftMenu, this._isShowRightMenu, this._isShowMixMenu);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtils.getScreenWidth(),
        height: ScreenUtils.getScreenHeight(),
        child: Stack(children: <Widget>[
          _menuItem(MenuType.MENU_TOP),
          _menuItem(MenuType.MENU_BOTTOM),
          _menuItem(MenuType.MENU_LEFT),
          _menuItem(MenuType.MENU_RIGHT)
        ]));
  }

  _menuItem(menuType) {
    Widget _menuWid;
    switch (menuType) {
      case MenuType.MENU_TOP:
        _menuWid = Opacity(
            opacity: _isShowTopMenu || _isShowMixMenu ? 1.0 : 0.0,
            child: _topMenuWid());
        break;
      case MenuType.MENU_BOTTOM:
        _menuWid = Opacity(
            opacity: _isShowBottomMenu || _isShowMixMenu ? 1.0 : 0.0,
            child: _bottomMenuWid());
        break;
      case MenuType.MENU_LEFT:
        _menuWid = Opacity(
            opacity: _isShowLeftMenu ? 1.0 : 0.0, child: _leftMenuWid());
        break;
      case MenuType.MENU_RIGHT:
        _menuWid = Opacity(
            opacity: _isShowRightMenu ? 1.0 : 0.0, child: _rightMenuWid());
        break;
    }
    return AnimatedBuilder(
        animation: _controller,
        child: _menuWid,
        builder: (BuildContext context, Widget child) {
          return CustomSingleChildLayout(
              delegate: ACEMenuDelegate(menuType, _controller.value),
              child: child);
        });
  }

  _topMenuWid() {
    return Container(
        color: Color(0xF3242424),
        height: 80.0,
        child: Column(children: <Widget>[
          SizedBox(height: 24.0),
          Row(children: <Widget>[
            Container(
                width: 56.0,
                height: 56.0,
                child: Center(
                    child: Icon(Icons.arrow_back_ios, color: Colors.white)))
          ])
        ]));
  }

  _bottomMenuWid() {
    return Container(
        color: Color(0xF3242424),
        height: 180.0,
        child: Row(children: <Widget>[]));
  }

  _leftMenuWid() {
    return Container(
        color: Color(0xF3242424),
        height: ScreenUtils.getScreenHeight(),
        child: Row(children: <Widget>[]));
  }

  _rightMenuWid() {
    return Container(
        color: Color(0xF3245424),
        height: ScreenUtils.getScreenHeight(),
        child: Row(children: <Widget>[]));
  }
}
