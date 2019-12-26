import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_marquee.dart';

class ACEMarqueePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEMarqueePageState();
}

class _ACEMarqueePageState extends State<ACEMarqueePage> {
  List<String> _list = [
    '人生犹如一本书，愚蠢者草草翻过，聪明人细细阅读。为何如此，因为他们只能读它一次。',
    '天才是百分之一的灵感加百分之九十九的汗水。',
    '深窥自己的心，而后发觉一切的奇迹在你自己。',
    '什么叫做失败？失败是到达较佳境地的第一步。'
  ];
  String _itemStr = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('ACEMarqueePage')),
            body: ListView(children: <Widget>[
              _marqueeWid01(),
              SizedBox(height: 4),
              _marqueeWid02('推荐', _list, AxisDirection.left),
              SizedBox(height: 4),
              _marqueeWid02('由右至左', _list, AxisDirection.right),
              SizedBox(height: 4),
              _marqueeWid02('由上至下', _list, AxisDirection.down),
              SizedBox(height: 4),
              _marqueeWid02('由下至上', _list, AxisDirection.up),
              SizedBox(height: 4),
              _marqueeWid03(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(_itemStr, style: TextStyle(fontSize: 16)))
            ])));
  }

  Widget _marqueeWid01() {
    return Container(
        child: ACEMarquee(
            children: <Widget>[
              Container(height: 100, color: Colors.orange),
              Container(height: 100, color: Colors.purpleAccent),
              Container(height: 100, color: Colors.redAccent),
              Container(height: 100, color: Colors.blueGrey)
            ],
            direction: AxisDirection.left,
            duration: Duration(milliseconds: 2000),
            onItemTap: (index) =>
                setState(() => _itemStr = '当前点击 item = ${index + 1}')));
  }

  Widget _marqueeWid02(recStr, list, direction) {
    List<Widget> _wList = List<Widget>();
    for (int i = 0; i < list.length; i++) {
      _wList.add(Container(
          width: 240,
          height: 50,
          alignment: Alignment.centerLeft,
          child: Text(list[i])));
    }
    return Container(
        height: 70,
        child: Row(children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(recStr, style: TextStyle(color: Colors.redAccent))),
          Container(
              width: 1,
              height: 20,
              color: Colors.grey,
              margin: EdgeInsets.symmetric(horizontal: 20)),
          ACEMarquee(
              children: _wList,
              direction: direction,
              duration: Duration(milliseconds: 2000),
              onItemTap: (index) =>
                  setState(() => _itemStr = '当前内容是：${_list[index]}'))
        ]));
  }

  Widget _marqueeWid03() {
    return Container(
        child: ACEMarquee(children: <Widget>[
          Container(height: 100, child: Image.asset('images/icon_hzw01.jpg')),
          Container(height: 100, child: Image.asset('images/icon_hzw02.jpg')),
          Container(height: 100, child: Image.asset('images/icon_hzw03.jpg')),
          Container(
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.android),
                    Icon(Icons.ac_unit),
                    Icon(Icons.backup),
                    Icon(Icons.cake)
                  ]))
        ], direction: AxisDirection.up, duration: Duration(milliseconds: 2000)));
  }
}
