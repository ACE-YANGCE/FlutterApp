import 'package:flutter/material.dart';
import 'package:flutter_app/menu/ace_page_bottom_menu.dart';
import 'package:flutter_app/menu/ace_page_left_menu.dart';
import 'package:flutter_app/menu/ace_page_top_menu.dart';
import 'package:flutter_app/menu/menu_enum.dart';
import 'package:flutter_app/menu/menu_manager.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';
import 'package:flutter_app/widget/ace_menu_delegate.dart';

class ACEPageMenu extends StatelessWidget {
  final bool _isShowTopMenu,
      _isShowBottomMenu,
      _isShowLeftMenu,
      _isShowRightMenu,
      _isShowMixMenu;
  final AnimationController _controller;
  final OnMenuItemClicked _menuItemClick;
  final MenuBottomType _bottomType;

  ACEPageMenu(
      this._controller,
      this._isShowTopMenu,
      this._isShowBottomMenu,
      this._isShowLeftMenu,
      this._isShowRightMenu,
      this._isShowMixMenu,
      this._bottomType,
      this._menuItemClick);

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
        _menuWid = Offstage(
            offstage: _isShowTopMenu || _isShowMixMenu ? false : true,
            child: ACEPageTopMenu(this._menuItemClick));
        break;
      case MenuType.MENU_BOTTOM:
        _menuWid = Offstage(
            offstage: _isShowBottomMenu || _isShowMixMenu ? false : true,
            child: ACEPageBottomMenu(_bottomType, this._menuItemClick));
        break;
      case MenuType.MENU_LEFT:
        _menuWid = Offstage(
            offstage: _isShowLeftMenu ? false : true,
            child: ACEPageLeftMenu(this._menuItemClick));
        break;
      case MenuType.MENU_RIGHT:
        _menuWid = Offstage(
            offstage: _isShowRightMenu ? false : true, child: _rightMenuWid());
        break;
    }
    return AnimatedBuilder(
        animation: _controller,
        child: _menuWid,
        builder: (BuildContext context, Widget child) {
          return CustomSingleChildLayout(
              delegate: ACEMenuDelegate(menuType, _controller.value),
              child: Offstage(
                  offstage: _controller.value == 0.0 ? true : false,
                  child: Opacity(opacity: _controller.value, child: child)));
        });
  }

  _rightMenuWid() {
    return Container(
        color: ColorUtils.menuBgColor,
        height: ScreenUtils.getScreenHeight(),
        child: Row(children: <Widget>[]));
  }
}
