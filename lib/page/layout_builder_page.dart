import 'package:flutter/material.dart';

class LayoutBuilderPage extends StatefulWidget {
  @override
  _LayoutBuilderPageState createState() => new _LayoutBuilderPageState();
}

class _LayoutBuilderPageState extends State<LayoutBuilderPage> {
  var _dataList = [
    ItemBean(Icons.collections, '收藏'),
    ItemBean(Icons.history, '历史记录'),
    ItemBean(Icons.details, '明细'),
    ItemBean(Icons.assignment_turned_in, '签到'),
    ItemBean(Icons.monetization_on, '金币商城'),
    ItemBean(Icons.card_giftcard, '大礼包'),
    ItemBean(Icons.settings, '设置'),
    ItemBean(Icons.more_horiz, '更多'),
  ];
  var _length = 0;
  var _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('LayoutBuilder Page')),
        body: ListView(children: <Widget>[
          LayoutBuilder(builder: (context, size) {
            if (size.maxWidth ~/ 90 >= 4 &&
                size.maxWidth ~/ 90 <= _dataList.length) {
              _length = size.maxWidth ~/ 90;
            } else if (size.maxWidth ~/ 90 > _dataList.length) {
              _length = _dataList.length;
            } else {
              _length = 4;
            }
            return _gridWid();
          })
        ]));
  }

  _gridWid() {
    return GridView.builder(
        physics: ScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _length,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1),
        itemCount: _showMore ? _dataList.length : _length,
        itemBuilder: (context, index) {
          var dataItem = _dataList[index];
          if (index < _length - 1 || _showMore) {
            dataItem = _dataList[index];
          } else {
            dataItem = _dataList[_dataList.length - 1];
          }
          return GestureDetector(
              child: Container(
                  color: Colors.white70,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(dataItem.icon),
                        SizedBox(height: 4),
                        Text(dataItem.text)
                      ])),
              onTap: () {
                if (_length < _dataList.length && dataItem.text == '更多') {
                  _showMore = !_showMore;
                  setState(() {});
                }
                print(
                    'Current item -->${dataItem.text == '更多' ? '更多' : _dataList[index].text}');
              });
        });
  }
}

class ItemBean {
  IconData icon;
  String text;

  ItemBean(IconData icon, String text) {
    this.icon = icon;
    this.text = text;
  }
}
