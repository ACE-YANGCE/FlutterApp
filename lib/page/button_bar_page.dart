import 'package:flutter/material.dart';

class ButtonBarPage extends StatefulWidget {
  @override
  _ButtonBarPageState createState() => new _ButtonBarPageState();
}

class _ButtonBarPageState extends State<ButtonBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ButtonBar Page')), body: _body01());
  }

  _body01() => ListView(children: [
        _buttonBarWid01(5),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid02(),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid03(),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid01(0),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid01(1),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid01(2),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid01(3),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid01(4),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid01(5),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid04(ButtonTextTheme.normal),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid04(ButtonTextTheme.accent),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid04(ButtonTextTheme.primary),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid06(100.0, 40.0, MainAxisAlignment.end),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid06(200.0, 70.0, MainAxisAlignment.end),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid07(10.0, 20.0),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid07(20.0, 40.0),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid08(VerticalDirection.up),
        Divider(height: 0.5, color: Colors.blue),
        _buttonBarWid08(VerticalDirection.down),
        Divider(height: 0.5, color: Colors.blue),
      ]);

  _body02() => Column(children: [
        SizedBox(height: 30.0),
        _buttonBarWid05(MainAxisSize.min),
        SizedBox(height: 10.0),
        Divider(height: 0.5, color: Colors.blue),
        SizedBox(height: 10.0),
        _buttonBarWid05(MainAxisSize.max),
      ]);

  _buttonBarWid01(index) {
    MainAxisAlignment alignment;
    if (index == 0) {
      alignment = MainAxisAlignment.start;
    } else if (index == 1) {
      alignment = MainAxisAlignment.center;
    } else if (index == 2) {
      alignment = MainAxisAlignment.spaceAround;
    } else if (index == 3) {
      alignment = MainAxisAlignment.spaceBetween;
    } else if (index == 4) {
      alignment = MainAxisAlignment.spaceEvenly;
    } else {
      alignment = MainAxisAlignment.end;
    }
    return ButtonBar(alignment: alignment, children: <Widget>[
      RaisedButton(child: Text('Button'), onPressed: null),
      // RaisedButton(child: Text('Button 02'), onPressed: null),
      RaisedButton(child: Text('${alignment.toString()}'), onPressed: null)
    ]);
  }

  _buttonBarWid02() => ButtonBar(children: <Widget>[
        RaisedButton(child: Text('Button 01'), onPressed: null),
        RaisedButton(child: Text('Button 02'), onPressed: null),
        RaisedButton(child: Text('Button 03'), onPressed: null),
        RaisedButton(child: Text('Button 04'), onPressed: null)
      ]);

  _buttonBarWid03() => ButtonBar(children: <Widget>[
        RaisedButton(child: Text('Button 01'), onPressed: null),
        RaisedButton(child: Text('Button 02'), onPressed: null),
        RaisedButton(child: Text('Button 03'), onPressed: null),
        RaisedButton(child: Text('Button 04'), onPressed: null),
        RaisedButton(child: Text('Button 05'), onPressed: null),
      ]);

  _buttonBarWid04(theme) =>
      ButtonBar(buttonTextTheme: theme, children: <Widget>[
        RaisedButton(child: Text('Button 01'), onPressed: null),
        RaisedButton(
            child: Text('Button 02', style: TextStyle(color: Colors.blue)),
            onPressed: null),
        RaisedButton(child: Text('${theme.toString()}'), onPressed: null),
      ]);

  _buttonBarWid05(mainAxisSize) => Container(
      color: Colors.blue.withOpacity(0.3),
      child: ButtonBar(mainAxisSize: mainAxisSize, children: <Widget>[
        RaisedButton(child: Text('Button 01'), onPressed: null),
        RaisedButton(child: Text('Button 02'), onPressed: null),
        RaisedButton(child: Text('Button 03'), onPressed: null)
      ]));

  _buttonBarWid06(width, height, alignment) =>
      ButtonBar(buttonMinWidth: width, buttonHeight: height, children: <Widget>[
        RaisedButton(child: Text('Button 01'), onPressed: null),
        RaisedButton(
            child: Text('Button 02', style: TextStyle(color: Colors.blue)),
            onPressed: null),
        RaisedButton(child: Text('${alignment.toString()}'), onPressed: null),
      ]);

  _buttonBarWid07(padding, spacing) => ButtonBar(
          overflowButtonSpacing: spacing,
          buttonPadding: EdgeInsets.all(padding),
          children: <Widget>[
            RaisedButton(child: Text('Button 01'), onPressed: null),
            RaisedButton(
                child: Text('Button 02', style: TextStyle(color: Colors.blue)),
                onPressed: null),
            RaisedButton(child: Text('Button 03'), onPressed: null)
          ]);

  _buttonBarWid08(direction) =>
      ButtonBar(overflowDirection: direction, children: <Widget>[
        RaisedButton(child: Text('Button 01'), onPressed: null),
        RaisedButton(
            child: Text('Button 02', style: TextStyle(color: Colors.blue)),
            onPressed: null),
        RaisedButton(child: Text('Button 03'), onPressed: null),
        RaisedButton(child: Text('${direction.toString()}'), onPressed: null),
      ]);
}
