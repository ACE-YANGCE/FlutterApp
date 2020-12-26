import 'package:flutter/material.dart';
import 'package:flutter_app/menu/menu_enum.dart';
import 'package:flutter_app/menu/menu_manager.dart';
import 'package:flutter_app/utils/color_utils.dart';

class ACEPageBottomMenu extends StatelessWidget {
  final MenuBottomType menuBottomType;
  final OnMenuItemClicked menuItemClick;

  ACEPageBottomMenu(this.menuBottomType, this.menuItemClick);

  @override
  Widget build(BuildContext context) {
    return _bottomMenu(this.menuBottomType);
  }

  _bottomMenu(type) {
    Widget _widget;
    switch (type) {
      case MenuBottomType.MENU_BOTTOM_COMMON:
        _widget = _commonMenu();
        break;
      case MenuBottomType.MENU_BOTTOM_SETTING:
        _widget = _settingMenu();
        break;
      case MenuBottomType.MENU_BOTTOM_SHARE:
        _widget = _shareMenu();
        break;
    }
    return _widget;
  }

  _commonMenu() {
    return Container(
        color: ColorUtils.menuBgColor,
        height: MenuManager.bottomCommonMenuHeight,
        child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: Row(children: <Widget>[
                GestureDetector(
                    child: Text('上一章', style: TextStyle(color: Colors.white)),
                    onTap: () =>
                        menuItemClick(MenuItemType.MENU_PRE_CHAPTER, null)),
                Expanded(
                    child: Slider(
                        min: 1,
                        max: 100,
                        divisions: 100,
                        activeColor: Colors.green,
                        inactiveColor: Colors.grey,
                        value: 31,
                        onChanged: (val) {})),
                GestureDetector(
                    child: Text('下一章', style: TextStyle(color: Colors.white)),
                    onTap: () =>
                        menuItemClick(MenuItemType.MENU_NEXT_CHAPTER, null))
              ])),
          SizedBox(height: 10),
          Row(children: <Widget>[
            _commonMenuItem(Icons.menu, '目录', MenuItemType.MENU_CATALOG, false),
            _commonMenuItem(Icons.lightbulb_outline, '亮度',
                MenuItemType.MENU_LIGHT_MODE, false),
            _commonMenuItem(
                Icons.brightness_3, '夜间', MenuItemType.MENU_NIGHT_MODE, false),
            _commonMenuItem(
                Icons.settings, '设置', MenuItemType.MENU_SETTING, false)
          ])
        ])));
  }

  _settingMenu() {
    return Container(height: 100, color: Colors.red);
  }

  _shareMenu() {
    return Container(
        color: ColorUtils.menuBgColor,
        height: MenuManager.bottomShareMenuHeight,
        child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 12),
              child: Row(children: <Widget>[
                _commonMenuItem('images/icon_wechat.png', '微信',
                    MenuItemType.MENU_WECHAT, true),
                _commonMenuItem('images/icon_wechat_moments.png', '朋友圈',
                    MenuItemType.MENU_WECHAT_MOMENT, true),
                _commonMenuItem(
                    'images/icon_qq.png', 'QQ', MenuItemType.MENU_QQ, true),
                _commonMenuItem(
                    'images/icon_qq.png', 'QQ空间', MenuItemType.MENU_QZONE, true)
              ])),
          Divider(height: 0.5, color: Colors.white),
          SizedBox(height: 10.0),
          GestureDetector(
              child: Text('关闭',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              onTap: () => menuItemClick(MenuItemType.MENU_CLOSE, null))
        ]));
  }

  _commonMenuItem(icon, name, type, isShare) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
            child: Column(children: <Widget>[
              isShare
                  ? Image.asset(icon, width: 45)
                  : Icon(icon, color: Colors.white),
              SizedBox(height: 10),
              Text(name, style: TextStyle(color: Colors.white))
            ]),
            onTap: () => menuItemClick(type, null)));
  }
}
