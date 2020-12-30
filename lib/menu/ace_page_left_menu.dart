import 'package:flutter/material.dart';
import 'package:flutter_app/menu/menu_enum.dart';
import 'package:flutter_app/menu/menu_manager.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/screen_utils.dart';

class ACEPageLeftMenu extends StatefulWidget {
  final OnMenuItemClicked menuItemClick;

  ACEPageLeftMenu(this.menuItemClick);

  @override
  State<StatefulWidget> createState() => _ACEPageLeftMenuState();
}

class _ACEPageLeftMenuState extends State<ACEPageLeftMenu> {
  var _currentIndex = 0;
  PageController _controller;

  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                                  fontSize: 16.0,
                                  color: _currentIndex == 0
                                      ? Colors.yellow
                                      : Colors.white)),
                          Icon(Icons.arrow_downward,
                              color: _currentIndex == 0
                                  ? Colors.yellow
                                  : Colors.white)
                        ]),
                    onTap: () {
                      widget.menuItemClick(
                          MenuItemType.MENU_LEFT_CATALOG, null);
                      setState(() {});
                      _currentIndex = 0;
                      _controller.animateToPage(0,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }),
                flex: 1),
            Expanded(
                child: GestureDetector(
                    child: Center(
                        child: Text('书签',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: _currentIndex == 1
                                    ? Colors.yellow
                                    : Colors.white))),
                    onTap: () {
                      setState(() {});
                      _currentIndex = 1;
                      _controller.animateToPage(1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                      widget.menuItemClick(MenuItemType.MENU_LEFT_TAG, null);
                    }),
                flex: 1)
          ]))
    ]);
  }

  _leftMenuPage() {
    return Expanded(
        child: PageView.builder(
            controller: _controller,
            itemBuilder: (context, position) =>
                _leftItemPage(context, position),
            itemCount: 2,
            onPageChanged: (position) {
              setState(() {});
              _currentIndex = position;
            }));
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
                          padding: EdgeInsets.all(10.0),
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Text(
                                    position == 0
                                        ? '目录 Tab 下当前 item '
                                            '= ${index + 1}'
                                        : '书签 Tab 下当前 item '
                                            '= ${index + 1}',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white))),
                            Padding(
                                child: Icon(Icons.lock_open,
                                    size: 14.0, color: Colors.white),
                                padding: EdgeInsets.only(left: 10.0))
                          ])),
                      onTap: () => widget.menuItemClick(
                          MenuItemType.MENU_LEFT_CATALOG_ITEM,
                          '当前 Catalog item = ${index + 1}'));
                })));
  }
}
