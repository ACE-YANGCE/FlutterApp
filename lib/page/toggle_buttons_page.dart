import 'package:flutter/material.dart';

class ToggleButtonsPage extends StatefulWidget {
  @override
  _ToggleButtonsPageState createState() => new _ToggleButtonsPageState();
}

class _ToggleButtonsPageState extends State<ToggleButtonsPage> {
  var iconList = [
    Icon(Icons.airplanemode_active),
    Icon(Icons.directions_bus),
    Icon(Icons.directions_bike)
  ];
  var textList = [Text('飞机'), Text('公交'), Text('骑行')];
  var minxList = [
    Column(children: [
      SizedBox(height: 8.0),
      Icon(Icons.airplanemode_active),
      SizedBox(height: 5.0),
      Text('飞机'),
      SizedBox(height: 8.0),
    ]),
    Column(children: [
      SizedBox(height: 8.0),
      Icon(Icons.directions_bus),
      SizedBox(height: 5.0),
      Text('公交'),
      SizedBox(height: 8.0)
    ]),
    Column(children: [
      SizedBox(height: 8.0),
      Icon(Icons.directions_bike),
      SizedBox(height: 5.0),
      Text('骑行'),
      SizedBox(height: 8.0)
    ])
  ];
  var stateList = [true, false, false];

  FocusNode focusNodeButton1 = FocusNode();
  FocusNode focusNodeButton2 = FocusNode();
  FocusNode focusNodeButton3 = FocusNode();
  List<FocusNode> focusToggle;
  var _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusToggle = [focusNodeButton1, focusNodeButton2, focusNodeButton3];
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNodeButton1.dispose();
    focusNodeButton2.dispose();
    focusNodeButton3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ToggleButtons Page')),
        body: ListView(children: [
          _toggleWid01(0),
          _toggleWid01(1),
          _toggleWid01(2),
          SizedBox(height: 10.0),
          Divider(height: 0.5, color: Colors.blue),
          Row(children: [
            Expanded(child: _toggleWid02(0, false)),
            Expanded(child: _toggleWid02(0, true))
          ]),
          Row(children: [
            Expanded(child: _toggleWid02(1, false)),
            Expanded(child: _toggleWid02(1, true))
          ]),
          Row(children: [
            Expanded(child: _toggleWid02(2, false)),
            Expanded(child: _toggleWid02(2, true))
          ]),
          SizedBox(height: 10.0),
          Divider(height: 0.5, color: Colors.blue),
          Row(children: [
            Expanded(child: _toggleWid03(0, false)),
            Expanded(child: _toggleWid03(0, true))
          ]),
          Row(children: [
            Expanded(child: _toggleWid03(1, false)),
            Expanded(child: _toggleWid03(1, true))
          ]),
          Row(children: [
            Expanded(child: _toggleWid03(2, false)),
            Expanded(child: _toggleWid03(2, true))
          ]),
          SizedBox(height: 10.0),
          Divider(height: 0.5, color: Colors.blue),
          Row(children: [
            Expanded(child: _toggleWid04(0, false)),
            Expanded(child: _toggleWid04(0, true))
          ]),
          Row(children: [
            Expanded(child: _toggleWid04(1, false)),
            Expanded(child: _toggleWid04(1, true))
          ]),
          Row(children: [
            Expanded(child: _toggleWid04(2, false)),
            Expanded(child: _toggleWid04(2, true))
          ]),
          SizedBox(height: 10.0),
          Divider(height: 0.5, color: Colors.blue),
          Row(children: [
            Expanded(child: _toggleWid05(0, false, 1.0, null)),
            Expanded(child: _toggleWid05(0, true, 1.0, null))
          ]),
          Row(children: [
            Expanded(
                child: _toggleWid05(
                    1, false, 2.0, BorderRadius.all(Radius.circular(40)))),
            Expanded(
                child: _toggleWid05(
                    1, true, 2.0, BorderRadius.all(Radius.circular(40))))
          ]),
          Row(children: [
            Expanded(
                child: _toggleWid05(
                    2,
                    false,
                    2.0,
                    BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)))),
            Expanded(
                child: _toggleWid05(
                    2,
                    true,
                    2.0,
                    BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))))
          ]),
          SizedBox(height: 10.0),
          Divider(height: 0.5, color: Colors.blue),
          Row(children: [
            Expanded(child: _toggleWid06(0, false, false)),
            Expanded(child: _toggleWid06(0, true, false))
          ]),
          Row(children: [
            Expanded(child: _toggleWid06(1, false, true)),
            Expanded(child: _toggleWid06(1, true, true))
          ]),
          SizedBox(height: 10.0),
          Divider(height: 0.5, color: Colors.blue),
          SizedBox(height: 10.0),
          _toggleWid07(50.0),
          SizedBox(height: 10.0),
          _toggleWid07(70.0),
          SizedBox(height: 10.0),
          _toggleWid07(100.0),
          SizedBox(height: 10.0),
          Divider(height: 0.5, color: Colors.blue),
          SizedBox(height: 10.0),
          _toggleWid08(),
          SizedBox(height: 10.0),
          _focusWid(),
          SizedBox(height: 10.0),
          Divider(height: 0.5, color: Colors.blue)
        ]));
  }

  _toggleWid01(index) {
    return Container(
        height: 80.0,
        child: Center(
            child: ToggleButtons(
                children: _getChildList(index), isSelected: stateList)));
  }

  _toggleWid02(index, isPressed) {
    return Container(
        height: 80.0,
        child: Center(
            child: ToggleButtons(
                children: _getChildList(index),
                isSelected: stateList,
                color: Colors.grey.withOpacity(0.4),
                selectedColor: Colors.deepOrange.withOpacity(0.4),
                disabledColor: Colors.deepPurple.withOpacity(0.4),
                onPressed: isPressed
                    ? (selectedIndex) => setState(() =>
                        stateList[selectedIndex] = !stateList[selectedIndex])
                    : null)));
  }

  _toggleWid03(index, isPressed) {
    return Container(
        height: 80.0,
        child: Center(
            child: ToggleButtons(
                children: _getChildList(index),
                isSelected: stateList,
                fillColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.deepOrange.withOpacity(0.4),
                splashColor: Colors.deepPurple.withOpacity(0.4),
                onPressed: isPressed
                    ? (selectedIndex) => setState(() =>
                        stateList[selectedIndex] = !stateList[selectedIndex])
                    : null)));
  }

  _toggleWid04(index, isPressed) {
    return Container(
        height: 80.0,
        child: Center(
            child: ToggleButtons(
                children: _getChildList(index),
                isSelected: stateList,
                borderColor: Colors.blue.withOpacity(0.4),
                selectedBorderColor: Colors.deepOrange.withOpacity(0.4),
                disabledBorderColor: Colors.deepPurple.withOpacity(0.4),
                onPressed: isPressed
                    ? (selectedIndex) => setState(() =>
                        stateList[selectedIndex] = !stateList[selectedIndex])
                    : null)));
  }

  _toggleWid05(index, isPressed, borderWidth, borderRadius) {
    return Container(
        height: 80.0,
        child: Center(
            child: ToggleButtons(
                children: _getChildList(index),
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

  _toggleWid06(index, isPressed, isBorder) {
    return Container(
        height: 80.0,
        child: Center(
            child: ToggleButtons(
                children: _getChildList(index),
                isSelected: stateList,
                renderBorder: isBorder,
                borderWidth: 2.0,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
                borderColor: Colors.blue.withOpacity(0.4),
                selectedBorderColor: Colors.deepOrange.withOpacity(0.4),
                disabledBorderColor: Colors.deepPurple.withOpacity(0.4),
                onPressed: isPressed
                    ? (selectedIndex) => setState(() =>
                        stateList[selectedIndex] = !stateList[selectedIndex])
                    : null)));
  }

  _toggleWid07(size) {
    return Container(
        child: Center(
            child: ToggleButtons(
                children: [
          Image(
              image: AssetImage('images/icon_hzw01.jpg'),
              fit: BoxFit.cover,
              width: size,
              height: size),
          Image(
              image: AssetImage('images/icon_hzw02.jpg'),
              fit: BoxFit.cover,
              width: size,
              height: size),
          Image(
              image: AssetImage('images/icon_hzw03.jpg'),
              fit: BoxFit.cover,
              width: size,
              height: size)
        ],
                isSelected: stateList,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
                constraints: BoxConstraints(minWidth: 70.0, minHeight: 70.0),
                borderWidth: 2.0,
                onPressed: (selectedIndex) => setState(() =>
                    stateList[selectedIndex] = !stateList[selectedIndex]))));
  }

  _toggleWid08() {
    return Container(
        height: 80.0,
        child: Center(
            child: ToggleButtons(
                children: iconList,
                isSelected: stateList,
                focusColor: Colors.red,
                focusNodes: focusToggle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                onPressed: (selectedIndex) => setState(() =>
                    stateList[selectedIndex] = !stateList[selectedIndex]))));
  }

  _focusWid() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      RaisedButton(
          child: Text('Previous'),
          onPressed: () {
            if (_index > iconList.length || _index <= 0) {
              _index = 0;
            } else {
              _index -= 1;
            }
            _requestFocus();
          }),
      SizedBox(width: 20),
      RaisedButton(
          child: Text('Next'),
          onPressed: () {
            if (_index >= iconList.length || _index < 0) {
              _index = iconList.length - 1;
            } else {
              _index += 1;
            }
            _requestFocus();
          })
    ]);
  }

  _requestFocus() {
    switch (_index) {
      case 0:
        FocusScope.of(context).requestFocus(focusNodeButton1);
        break;
      case 1:
        FocusScope.of(context).requestFocus(focusNodeButton2);
        break;
      case 2:
        FocusScope.of(context).requestFocus(focusNodeButton3);
        break;
    }
  }

  _getChildList(index) {
    var childList;
    if (index == 0) {
      childList = iconList;
    } else if (index == 1) {
      childList = textList;
    } else {
      childList = minxList;
    }
    return childList;
  }
}
