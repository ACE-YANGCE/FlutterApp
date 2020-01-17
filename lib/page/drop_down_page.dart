import 'package:flutter/material.dart';

class DropDownPage extends StatefulWidget {
  @override
  _DropDownPageState createState() => new _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  var _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('DropdownButton Page')),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid01()),
                SizedBox(width: 10),
                Expanded(child: _itemWid02())
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid03()),
                SizedBox(width: 10),
                Expanded(child: _itemWid04())
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid05()),
                SizedBox(width: 10),
                Expanded(child: _itemWid06())
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid07()),
                SizedBox(width: 10),
                Expanded(child: _itemWid08())
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid09()),
                SizedBox(width: 10),
                Expanded(child: _itemWid10())
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid11()),
                SizedBox(width: 10),
                Expanded(child: _itemWid12())
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid13()),
                SizedBox(width: 10),
                Expanded(child: _itemWid14())
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid15(false)),
                SizedBox(width: 10),
                Expanded(child: _itemWid16(false))
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid15(true)),
                SizedBox(width: 10),
                Expanded(child: _itemWid16(true))
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid17()),
                SizedBox(width: 10),
                Expanded(child: _itemWid18())
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid19(null)),
                SizedBox(width: 10),
                Expanded(
                    child:
                        _itemWid19(TextStyle(color: Colors.blue, fontSize: 18)))
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: _itemWid20(null)),
                SizedBox(width: 10),
                Expanded(
                    child:
                        _itemWid20(TextStyle(color: Colors.blue, fontSize: 18)))
              ]),
            ])));
  }

  _itemWid01() {
    return DropdownButton(items: null, onChanged: null);
  }

  _itemWid02() {
    return DropdownButton(items: [
      DropdownMenuItem(child: Text('北京')),
      DropdownMenuItem(child: Text('天津')),
      DropdownMenuItem(child: Text('河北'))
    ], onChanged: (value) {});
  }

  _itemWid03() {
    return DropdownButton(
        items: null,
        onChanged: null,
        icon: Icon(Icons.arrow_right),
        iconSize: 40);
  }

  _itemWid04() {
    return DropdownButton(
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        items: [
          DropdownMenuItem(child: Text('北京')),
          DropdownMenuItem(child: Text('天津')),
          DropdownMenuItem(child: Text('河北'))
        ],
        onChanged: (value) {});
  }

  _itemWid05() {
    return DropdownButton(
        items: null,
        onChanged: null,
        icon: Icon(Icons.arrow_right,
            color: Colors.blue.withOpacity(0.7), size: 60),
        iconSize: 40);
  }

  _itemWid06() {
    return DropdownButton(
        icon: Icon(Icons.arrow_right, color: Colors.blue.withOpacity(0.7)),
        iconSize: 40,
        items: [
          DropdownMenuItem(child: Text('北京')),
          DropdownMenuItem(child: Text('天津')),
          DropdownMenuItem(child: Text('河北'))
        ],
        onChanged: (value) {});
  }

  _itemWid07() {
    return DropdownButton(
      items: null,
      onChanged: null,
      icon: Icon(Icons.arrow_right),
      iconSize: 40,
      iconDisabledColor: Colors.redAccent.withOpacity(0.7),
    );
  }

  _itemWid08() {
    return DropdownButton(
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconEnabledColor: Colors.green.withOpacity(0.7),
        items: [
          DropdownMenuItem(child: Text('北京')),
          DropdownMenuItem(child: Text('天津')),
          DropdownMenuItem(child: Text('河北'))
        ],
        onChanged: (value) {});
  }

  _itemWid09() {
    return DropdownButton(
        items: null,
        onChanged: null,
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconDisabledColor: Colors.redAccent.withOpacity(0.7),
        disabledHint: Text('暂不可用'));
  }

  _itemWid10() {
    return DropdownButton(
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconEnabledColor: Colors.green.withOpacity(0.7),
        hint: Text('请选择地区'),
        items: [
          DropdownMenuItem(child: Text('北京'), value: 1),
          DropdownMenuItem(child: Text('天津'), value: 2),
          DropdownMenuItem(child: Text('河北'), value: 3)
        ],
        onChanged: (value) {});
  }

  _itemWid11() {
    return DropdownButton(
      items: null,
      onChanged: null,
      icon: Icon(Icons.arrow_right),
      iconSize: 40,
      iconDisabledColor: Colors.redAccent.withOpacity(0.7),
      disabledHint: Text('暂不可用'),
      underline: Container(height: 4, color: Colors.redAccent.withOpacity(0.7)),
    );
  }

  _itemWid12() {
    return DropdownButton(
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconEnabledColor: Colors.green.withOpacity(0.7),
        hint: Text('请选择地区'),
        underline: Container(height: 4, color: Colors.green.withOpacity(0.7)),
        items: [
          DropdownMenuItem(child: Text('北京'), value: 1),
          DropdownMenuItem(child: Text('天津'), value: 2),
          DropdownMenuItem(child: Text('河北'), value: 3)
        ],
        onChanged: (value) {});
  }

  _itemWid13() {
    return DropdownButton(
      items: null,
      onChanged: null,
      icon: Icon(Icons.arrow_right),
      iconSize: 40,
      iconDisabledColor: Colors.redAccent.withOpacity(0.7),
      disabledHint: Text('暂不可用'),
      underline: Container(height: 0),
    );
  }

  _itemWid14() {
    return DropdownButton(
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconEnabledColor: Colors.green.withOpacity(0.7),
        hint: Text('请选择地区'),
        underline: Container(height: 0),
        items: [
          DropdownMenuItem(child: Text('北京'), value: 1),
          DropdownMenuItem(child: Text('天津'), value: 2),
          DropdownMenuItem(child: Text('河北'), value: 3)
        ],
        onChanged: (value) {});
  }

  _itemWid15(isDense) {
    return Container(
        color: Colors.blue.withOpacity(0.2),
        child: DropdownButton(
          items: null,
          onChanged: null,
          icon: Icon(Icons.arrow_right),
          iconSize: 40,
          iconDisabledColor: Colors.redAccent.withOpacity(0.7),
          disabledHint: Text('暂不可用'),
          underline:
              Container(height: 4, color: Colors.redAccent.withOpacity(0.7)),
          isDense: isDense,
        ));
  }

  _itemWid16(isDense) {
    return Container(
        color: Colors.blue.withOpacity(0.2),
        child: DropdownButton(
            icon: Icon(Icons.arrow_right),
            iconSize: 40,
            iconEnabledColor: Colors.green.withOpacity(0.7),
            hint: Text('请选择地区'),
            underline:
                Container(height: 4, color: Colors.green.withOpacity(0.7)),
            isDense: isDense,
            items: [
              DropdownMenuItem(child: Text('北京'), value: 1),
              DropdownMenuItem(child: Text('天津'), value: 2),
              DropdownMenuItem(child: Text('河北'), value: 3)
            ],
            onChanged: (value) {}));
  }

  _itemWid17() {
    return DropdownButton(
      items: null,
      onChanged: null,
      icon: Icon(Icons.arrow_right),
      iconSize: 40,
      iconDisabledColor: Colors.redAccent.withOpacity(0.7),
      disabledHint: Text('暂不可用'),
      isExpanded: true,
      underline: Container(height: 1, color: Colors.redAccent.withOpacity(0.7)),
    );
  }

  _itemWid18() {
    return DropdownButton(
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconEnabledColor: Colors.green.withOpacity(0.7),
        hint: Text('请选择地区'),
        isExpanded: true,
        underline: Container(height: 1, color: Colors.green.withOpacity(0.7)),
        items: [
          DropdownMenuItem(child: Text('北京'), value: 1),
          DropdownMenuItem(child: Text('天津'), value: 2),
          DropdownMenuItem(child: Text('河北'), value: 3)
        ],
        onChanged: (value) {});
  }

  _itemWid19(style) {
    return DropdownButton(
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconEnabledColor: Colors.green.withOpacity(0.7),
        hint: Text('请选择地区'),
        isExpanded: true,
        underline: Container(height: 1, color: Colors.green.withOpacity(0.7)),
        style: style,
        items: [
          DropdownMenuItem(child: Text('北京'), value: 1),
          DropdownMenuItem(child: Text('天津'), value: 2),
          DropdownMenuItem(child: Text('河北'), value: 3)
        ],
        onChanged: (value) {});
  }

  _itemWid20(style) {
    return DropdownButton(
        value: _value,
        icon: Icon(Icons.arrow_right),
        iconSize: 40,
        iconEnabledColor: Colors.green.withOpacity(0.7),
        hint: Text('请选择地区'),
        isExpanded: true,
        underline: Container(height: 1, color: Colors.green.withOpacity(0.7)),
        style: style,
        items: [
          DropdownMenuItem(
              child: Row(children: <Widget>[
                Text('北京'),
                SizedBox(width: 10),
                Icon(Icons.ac_unit)
              ]),
              value: 1),
          DropdownMenuItem(
              child: Row(children: <Widget>[
                Text('天津'),
                SizedBox(width: 10),
                Icon(Icons.content_paste)
              ]),
              value: 2),
          DropdownMenuItem(
              child: Row(children: <Widget>[
                Text('河北',
                    style: TextStyle(color: Colors.purpleAccent, fontSize: 16)),
                SizedBox(width: 10),
                Icon(Icons.send, color: Colors.purpleAccent)
              ]),
              value: 3)
        ],
        onChanged: (value) => setState(() => _value = value));
  }
}
