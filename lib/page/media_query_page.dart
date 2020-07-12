import 'package:flutter/material.dart';

class MediaQueryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MediaQueryPageState();
}

class _MediaQueryPageState extends State<MediaQueryPage> {
  var _itemExpandedKey = GlobalKey();
  var _itemTextKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print('${MediaQuery.of(context).toString()}');
    return Scaffold(
        appBar: AppBar(title: Text("MediaQuery Page")),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: ListView(children: <Widget>[
              Row(children: <Widget>[
                _itemBtn('屏幕 Size', 1, Colors.pinkAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                Expanded(
                    key: _itemExpandedKey,
                    child: FlatButton(
                        onPressed: () => _itemClick(2),
                        child: Center(
                            child: Text('按钮 Size',
                                key: _itemTextKey,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0))),
                        color: Colors.purpleAccent.withOpacity(0.4)))
              ]),
              Row(children: <Widget>[
                _itemBtn('横竖屏幕', 3, Colors.blueAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('屏幕像素比', 4, Colors.blueGrey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('字体像素比', 5, Colors.orange.withOpacity(0.4)),
                SizedBox(width: 4),
                Expanded(
                    child: FlatButton(
                        onPressed: () => _itemClick(6),
                        child: Center(
                            child: MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(textScaleFactor: 1.2),
                                child: Text('字体像素比 * 1.2',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0)))),
                        color: Colors.deepOrangeAccent.withOpacity(0.4)))
              ]),
              Row(children: <Widget>[
                _itemBtn('亮度模式', 7, Colors.pink.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('24 小时制', 8, Colors.pinkAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('辅助视力障碍', 9, Colors.blueAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('颜色反转', 10, Colors.blueGrey.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('前后背景高对比度', 11, Colors.green.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('是否减少动画', 12, Colors.teal.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('是否使用粗体', 13, Colors.pinkAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('内边距', 14, Colors.purpleAccent.withOpacity(0.4))
              ]),
              Row(children: <Widget>[
                _itemBtn('键盘遮挡内边距', 15, Colors.blueAccent.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('系统手势边距', 16, Colors.blueGrey.withOpacity(0.4))
              ]),
              TextField(),
              Row(children: <Widget>[
                _itemBtn('视图内边距', 17, Colors.orange.withOpacity(0.4)),
                SizedBox(width: 4),
                _itemBtn('设备物理层级', 18, Colors.deepOrangeAccent.withOpacity(0.4))
              ]),
            ])));
  }

  _itemBtn(text, index, color) {
    return Expanded(
        child: FlatButton(
            onPressed: () => _itemClick(index),
            child: Center(
                child: Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 16.0))),
            color: color));
  }

  _itemClick(index) {
    print('Current Button $index click --> start');
    switch (index) {
      case 1:
        print('屏幕 Size -> ${MediaQuery.of(context).size}');
        break;
      case 2:
        print('按钮 Size -> ${_itemExpandedKey.currentContext.size}');
        print('文字 Size -> ${_itemTextKey.currentContext.size}');
        print('文字 Size -> ${MediaQuery.of(_itemTextKey.currentContext).size}}');
        break;
      case 3:
        print('横竖屏 -> ${MediaQuery.of(context).orientation}');
        break;
      case 4:
        print('屏幕像素比 -> ${MediaQuery.of(context).devicePixelRatio}');
        break;
      case 5:
        print('字体像素比 -> ${MediaQuery.of(context).textScaleFactor}');
        break;
      case 6:
        print(
            '字体像素比 * 1.2 -> ${MediaQuery.of(context).copyWith(textScaleFactor: 1.2).textScaleFactor}');
        break;
      case 7:
        print('亮度模式 -> ${MediaQuery.of(context).platformBrightness}');
        break;
      case 8:
        print('24 小时制 -> ${MediaQuery.of(context).alwaysUse24HourFormat}');
        break;
      case 9:
        print('辅助视力障碍 -> ${MediaQuery.of(context).accessibleNavigation}');
        break;
      case 10:
        print('颜色反转 -> ${MediaQuery.of(context).invertColors}');
        break;
      case 11:
        print('前后背景高对比度 -> ${MediaQuery.of(context).highContrast}');
        break;
      case 12:
        print('是否减少动画 -> ${MediaQuery.of(context).disableAnimations}');
        break;
      case 13:
        print('是否使用粗体 -> ${MediaQuery.of(context).boldText}');
        break;
      case 14:
        print('内边距 -> ${MediaQuery.of(context).padding}');
        break;
      case 15:
        print('键盘遮挡内边距 -> ${MediaQuery.of(context).viewInsets}');
        break;
      case 16:
        print('系统手势边距 -> ${MediaQuery.of(context).systemGestureInsets}');
        break;
      case 17:
        print('视图内边距 -> ${MediaQuery.of(context).viewPadding}');
        break;
      case 18:
        print('设备物理层级 -> ${MediaQuery.of(context).physicalDepth}');
        break;
    }
    print('Current Button $index click --> end');
  }
}
