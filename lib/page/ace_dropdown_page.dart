import 'package:flutter/material.dart';
import 'package:flutter_app/utils/common_line_painter.dart';
import 'package:flutter_app/widget/ace_dropdown_button.dart';

class ACEDropDownPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEDropDownPageState();
}

class _ACEDropDownPageState extends State<ACEDropDownPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Stack(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(painter: CommonLinePainter(context, 50.0))),
      Column(children: <Widget>[
        Expanded(child: Center(child: _itemDropDown01())),
        Expanded(child: Center(child: _itemDropDown02())),
        Expanded(child: Center(child: _itemDropDown04()), flex: 2),
        Expanded(child: Center(child: _itemDropDown03())),
        Expanded(child: Center(child: _itemDropDown04()))
      ])
    ])));
  }

  String dropdownValue = '北京市';

  _itemDropDown01() {
    return ACEDropdownButton<String>(
        value: dropdownValue,
        backgroundColor: Colors.yellow.withOpacity(0.8),
        onChanged: (String newValue) =>
            setState(() => dropdownValue = newValue),
        items: <String>['北京市', '天津市', '河北省', '其它']
            .map<ACEDropdownMenuItem<String>>((String value) {
          return ACEDropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
  }

  _itemDropDown02() {
    return ACEDropdownButton<String>(
        value: dropdownValue,
        backgroundColor: Colors.yellow.withOpacity(0.8),
        menuRadius: const BorderRadius.all(Radius.circular(15.0)),
        onChanged: (String newValue) =>
            setState(() => dropdownValue = newValue),
        items: <String>['北京市', '天津市', '河北省', '其它']
            .map<ACEDropdownMenuItem<String>>((String value) {
          return ACEDropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
  }

  _itemDropDown03() {
    return ACEDropdownButton<String>(
        value: dropdownValue,
        backgroundColor: Colors.yellow.withOpacity(0.8),
        menuRadius: const BorderRadius.all(Radius.circular(15.0)),
        isChecked: true,
        iconChecked: Icon(Icons.tag_faces),
        onChanged: (String newValue) =>
            setState(() => dropdownValue = newValue),
        items: <String>['北京市', '天津市', '河北省', '其它']
            .map<ACEDropdownMenuItem<String>>((String value) {
          return ACEDropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
  }

  var dropdownValue01 = '北京市';
  _itemDropDown04() {
    return ACEDropdownButton<String>(
        value: dropdownValue01,
        menuRadius: const BorderRadius.all(Radius.circular(15.0)),
        isChecked: true,
        onChanged: (String newValue) =>
            setState(() => dropdownValue01 = newValue),
        items: <String>[
          '北京市',
          '天津市',
          '上海市',
          '河北省',
          '河南省',
          '山西省',
          '四川省',
          '云南省',
          '贵州省',
          '其它'
        ].map<ACEDropdownMenuItem<String>>((String value) {
          return ACEDropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
  }
}
