import 'package:flutter/material.dart';
import 'package:flutter_app/menu/menu_enum.dart';
import 'package:flutter_app/menu/menu_manager.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';

class ACEPageLeftMenu extends StatelessWidget {
  final OnMenuItemClicked menuItemClick;

  ACEPageLeftMenu(this.menuItemClick);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorUtils.menuBgColor,
        height: ScreenUtils.getScreenHeight(),
        child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[_leftMenuHeader(), _leftMenuPage()])));
  }

  _leftMenuHeader() {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(12.0, 40.0, 12.0, 2.0),
          child: Row(children: <Widget>[
            Image.asset('images/icon_hzw02.jpg', width: 80, height: 120),
            SizedBox(width: 10.0),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text('海贼王',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
                  SizedBox(height: 6.0),
                  Text('连载中 更新到800章',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: Colors.white))
                ]))
          ])),
      Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(children: <Widget>[
            Expanded(
                child: GestureDetector(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('目录',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white)),
                          Icon(Icons.arrow_downward, color: Colors.white)
                        ]),
                    onTap: () =>
                        menuItemClick(MenuItemType.MENU_LEFT_CATALOG, null)),
                flex: 1),
            Expanded(
                child: GestureDetector(
                    child: Center(
                        child: Text('书签',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.white))),
                    onTap: () =>
                        menuItemClick(MenuItemType.MENU_LEFT_TAG, null)),
                flex: 1)
          ]))
    ]);
  }

  _leftMenuPage() {
    return Expanded(
        child: PageView.builder(
            itemBuilder: (context, position) =>
                _leftItemPage(context, position),
            itemCount: 2));
  }

  _leftItemPage(context, position) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
            child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Text(
                                    '当前 item = 当前 item = 当前 item =${index + 1}',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white))),
                            Padding(
                                child: Icon(Icons.lock_open,
                                    size: 14.0, color: Colors.white),
                                padding: EdgeInsets.only(left: 10.0))
                          ])),
                      onTap: () => menuItemClick(
                          MenuItemType.MENU_LEFT_CATALOG_ITEM,
                          '当前 Catalog item = ${index + 1}'));
                })));
  }
}
