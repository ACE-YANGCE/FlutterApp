import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SegmentedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SegmentedPageState();
}

class _SegmentedPageState extends State<SegmentedPage> {
  var stateList = [true, false, false];
  var iconList = [
    Icon(Icons.airplanemode_active),
    Icon(Icons.directions_bus),
    Icon(Icons.directions_bike)
  ];
  var mixMap = {
    '飞机': Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Icon(Icons.airplanemode_active)),
    '公交': Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Icon(Icons.directions_bus)),
    '骑行': Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Icon(Icons.directions_bike))
  };
  var _currentIndexStr = '飞机';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Segmented Page')),
            body: ListView(children: [
              _titleWid('ToggleButtons'),
              _togglesWid(),
              _titleWid('CupertinoSegmentedControl'),
              SizedBox(height: 10.0),
              _segmentedWid01(),
              SizedBox(height: 20.0),
              _segmentedWid02(),
              SizedBox(height: 20.0),
              _segmentedWid03(),
              SizedBox(height: 20.0),
              _segmentedWid04(),
              SizedBox(height: 20.0),
              _segmentedWid05(),
              SizedBox(height: 20.0),
              _segmentedWid06(),
              SizedBox(height: 20.0),
              _segmentedWid07()
            ])));
  }

  _segmentedWid01() => Container(
      child: CupertinoSegmentedControl(
          children: mixMap,
          onValueChanged: (index) {
            print('index -> $index');
            setState(() => _currentIndexStr = index);
          }));

  _segmentedWid02() => Container(
      child: CupertinoSegmentedControl(
          children: mixMap,
          onValueChanged: (index) {
            print('index -> $index');
            setState(() => _currentIndexStr = index);
          },
          groupValue: _currentIndexStr));

  _segmentedWid03() => Container(
      child: CupertinoSegmentedControl(
          children: mixMap,
          onValueChanged: (index) {
            print('index -> $index');
            setState(() => _currentIndexStr = index);
          },
          groupValue: _currentIndexStr,
          unselectedColor: Colors.black.withOpacity(0.2)));

  _segmentedWid04() => Container(
      child: CupertinoSegmentedControl(
          children: mixMap,
          onValueChanged: (index) {
            print('index -> $index');
            setState(() => _currentIndexStr = index);
          },
          groupValue: _currentIndexStr,
          unselectedColor: Colors.black.withOpacity(0.2),
          selectedColor: Colors.deepOrange.withOpacity(0.4)));

  _segmentedWid05() => Container(
      child: CupertinoSegmentedControl(
          children: mixMap,
          onValueChanged: (index) {
            print('index -> $index');
            setState(() => _currentIndexStr = index);
          },
          groupValue: _currentIndexStr,
          unselectedColor: Colors.black.withOpacity(0.2),
          selectedColor: Colors.deepOrange.withOpacity(0.4),
          borderColor: Colors.deepPurple));

  _segmentedWid06() => Container(
      child: CupertinoSegmentedControl(
          children: mixMap,
          onValueChanged: (index) {
            print('index -> $index');
            setState(() => _currentIndexStr = index);
          },
          groupValue: _currentIndexStr,
          unselectedColor: Colors.black.withOpacity(0.2),
          selectedColor: Colors.deepOrange.withOpacity(0.4),
          borderColor: Colors.deepPurple,
          pressedColor: Colors.green.withOpacity(0.4)));

  _segmentedWid07() => Container(
      child: CupertinoSegmentedControl(
          children: mixMap,
          onValueChanged: (index) {
            print('index -> $index');
            setState(() => _currentIndexStr = index);
          },
          groupValue: _currentIndexStr,
          unselectedColor: Colors.black.withOpacity(0.2),
          selectedColor: Colors.deepOrange.withOpacity(0.4),
          borderColor: Colors.deepPurple,
          pressedColor: Colors.green.withOpacity(0.4),
          padding: EdgeInsets.all(30.0)));

  _togglesWid() => Row(children: [
        Expanded(
            child: _toggleItemWid(
                2,
                false,
                2.0,
                BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)))),
        Expanded(
            child: _toggleItemWid(
                2,
                true,
                2.0,
                BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))))
      ]);

  _toggleItemWid(index, isPressed, borderWidth, borderRadius) {
    return Container(
        height: 80.0,
        child: Center(
            child: ToggleButtons(
                children: iconList,
                isSelected: stateList,
                borderWidth: borderWidth,
                borderRadius: borderRadius,
                borderColor: Colors.blue.withOpacity(0.4),
                selectedBorderColor: Colors.deepOrange.withOpacity(0.4),
                disabledBorderColor: Colors.deepPurple.withOpacity(0.4),
                onPressed: isPressed
                    ? (selectedIndex) => setState(() =>
                        stateList[selectedIndex] = !stateList[selectedIndex])
                    : null)));
  }

  _titleWid(title) => Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(title, style: TextStyle(fontSize: 18.0, color: Colors.blue)));
}
