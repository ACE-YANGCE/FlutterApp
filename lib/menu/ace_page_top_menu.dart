import 'package:flutter/material.dart';
import 'package:flutter_app/menu/menu_enum.dart';
import 'package:flutter_app/menu/menu_manager.dart';
import 'package:flutter_app/utils/color_utils.dart';

class ACEPageTopMenu extends StatelessWidget {
  final OnMenuItemClicked menuItemClick;

  ACEPageTopMenu(this.menuItemClick);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorUtils.menuBgColor,
        height: MenuManager.topMenuHeight,
        child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  _topItemMenu(Icons.arrow_back_ios, MenuItemType.MENU_BACK),
                  Expanded(flex: 1, child: Container()),
                  _topItemMenu(Icons.file_download, MenuItemType.MENU_DOWNLOAD),
                  _topItemMenu(Icons.more_horiz, MenuItemType.MENU_MORE)
                ])));
  }

  _topItemMenu(icon, type) {
    return GestureDetector(
        child: Container(
            height: MenuManager.topMenuIconSize,
            width: MenuManager.topMenuIconSize,
            child: Center(child: Icon(icon, color: Colors.white))),
        onTap: () => menuItemClick(type, null));
  }
}
