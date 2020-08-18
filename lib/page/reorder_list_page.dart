import 'package:flutter/material.dart';
import 'package:flutter_app/page/layout_builder_page.dart';
import 'package:flutter_app/widget/ace_wave.dart';

class ReorderListPage extends StatefulWidget {
  @override
  _ReorderListPageState createState() => new _ReorderListPageState();
}

class _ReorderListPageState extends State<ReorderListPage> {
  var _dataList = [
    ItemBean(Icons.print, 'Current item --> print'),
    ItemBean(Icons.settings, 'Current item --> settings'),
    ItemBean(Icons.more, 'Current item --> more'),
    ItemBean(Icons.card_giftcard, 'Current item --> card_giftcard'),
    ItemBean(
        Icons.assignment_turned_in, 'Current item --> assignment_turned_in'),
    ItemBean(Icons.assignment, 'Current item --> assignment'),
    ItemBean(Icons.monetization_on, 'Current item --> monetization_on'),
    ItemBean(Icons.details, 'Current item --> details'),
    ItemBean(Icons.history, 'Current item --> history'),
    ItemBean(Icons.collections, 'Current item --> collections'),
    ItemBean(Icons.android, 'Current item --> android'),
    ItemBean(Icons.work, 'Current item --> work'),
    ItemBean(Icons.directions_car, 'Current item --> directions_car'),
    ItemBean(Icons.ac_unit, 'Current item --> ac_unit'),
    ItemBean(Icons.map, 'Current item --> map'),
  ];
  List<double> waveWidth = [600, 800, 300];
  List<double> waveHeight = [60, 80, 70];
  List<double> startOffsetX = [30, 150, 100];
  List<double> startOffsetY = [100, 120, 100];
  List<Duration> duration = [
    Duration(milliseconds: 6000),
    Duration(milliseconds: 4000),
    Duration(milliseconds: 5000)
  ];
  List<List<Color>> colorList = [
    [Colors.green.withOpacity(0.2), Colors.white.withOpacity(0.4)],
    [Colors.blue.withOpacity(0.2), Colors.white.withOpacity(0.4)],
    [Colors.blue.withOpacity(0.4), Colors.white.withOpacity(0.4)]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ReorderableListView Page')),
        body: ReorderableListView(
            header: _headerWid(false),
            reverse: false,
            scrollDirection: Axis.vertical,
            children: _listWid(false),
            onReorder: (oldIndex, newIndex) {
              if (newIndex == _dataList.length) {
                --newIndex;
              }
              final temp = _dataList.removeAt(oldIndex);
              _dataList.insert(newIndex, temp);
              setState(() {});
            }));
  }

  _listData(index, horizontal) {
    return Padding(
        key: ValueKey(_dataList[index]),
        padding: EdgeInsets.all(20.0),
        child: horizontal
            ? Column(children: <Widget>[
                Icon(_dataList[index].icon, color: Colors.black38),
                SizedBox(height: 10.0),
                Expanded(child: Text(_dataList[index].text)),
              ])
            : Row(children: <Widget>[
                Icon(_dataList[index].icon, color: Colors.black38),
                SizedBox(width: 10.0),
                Expanded(child: Text(_dataList[index].text)),
                Icon(Icons.arrow_right, color: Colors.black38)
              ]));
  }

  _listWid(horizontal) => <Widget>[
        for (int i = 0; i < _dataList.length; i++) _listData(i, horizontal)
      ];

  _headerWid(horizontal) {
    return horizontal
        ? Container()
        : Container(
            height: 200.0,
            child: ACEWave(waveWidth, waveHeight, 200.0,
                startOffsetXList: startOffsetX,
                startOffsetYList: startOffsetY,
                durationList: duration,
                waveColorList: colorList));
  }
}
