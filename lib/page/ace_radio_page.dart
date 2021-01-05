import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_radio.dart';

class ACERadioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACERadioState();
}

enum GenderType { MALE, FEMALE }
enum SizeType { SIZE_6, SIZE_8, SIZE_10, SIZE_14, SIZE_18 }

class _ACERadioState extends State<ACERadioPage> {
  var _groupValue = GenderType.MALE;
  var _groupSizeValue = SizeType.SIZE_8;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('ACERadio')),
            body: ListView(
              children: <Widget>[
                SizedBox(height: 10.0),
                Text('Radio 单选框',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 10.0),
                _radioWid01(),
                SizedBox(height: 10.0),
                _radioWid02(),
                SizedBox(height: 10.0),
                _radioWid03(),
                SizedBox(height: 10.0),
                _radioWid04(),
                SizedBox(height: 10.0),
                _radioWid05(),
                SizedBox(height: 10.0),
                Divider(height: 1, color: Colors.grey),
                SizedBox(height: 10.0),
                Text('ACERadio 自定义单选框',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 10.0),
                _aceRadioWid01(),
                SizedBox(height: 10.0),
                _aceRadioWid02(),
                SizedBox(height: 10.0),
                _aceRadioWid03(),
                SizedBox(height: 10.0),
                _aceRadioWid04(),
                SizedBox(height: 10.0),
                _aceRadioWid05(),
                SizedBox(height: 10.0),
                _aceRadioWid06(),
                SizedBox(height: 10.0)
              ],
            )));
  }

  _radioWid01() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Radio(
          value: GenderType.MALE,
          groupValue: _groupValue,
          onChanged: (val) {
            print('---onChanged---$val');
            setState(() => _groupValue = val);
          }),
      Radio(
          value: GenderType.FEMALE,
          groupValue: _groupValue,
          onChanged: (val) {
            print('---onChanged---$val');
            setState(() => _groupValue = val);
          }),
    ]);
  }

  _radioWid02() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(children: <Widget>[
        Radio(
            value: GenderType.MALE,
            groupValue: _groupValue,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('男')
      ]),
      Row(children: <Widget>[
        Radio(
            value: GenderType.FEMALE,
            groupValue: _groupValue,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('女')
      ]),
      Row(children: <Widget>[
        Radio(
            value: GenderType.FEMALE, groupValue: _groupValue, onChanged: null),
        Text('不可选中')
      ])
    ]);
  }

  _radioWid03() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(children: <Widget>[
        Text('padded'),
        Container(
            color: Colors.grey.withOpacity(0.4),
            child: Radio(
                value: GenderType.MALE,
                groupValue: _groupValue,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onChanged: (val) {
                  print('---onChanged---$val');
                  setState(() => _groupValue = val);
                })),
      ]),
      SizedBox(width: 10),
      Row(children: <Widget>[
        Container(
            color: Colors.grey.withOpacity(0.4),
            child: Radio(
                value: GenderType.FEMALE,
                groupValue: _groupValue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (val) {
                  print('---onChanged---$val');
                  setState(() => _groupValue = val);
                })),
        Text('shrinkWrap')
      ])
    ]);
  }

  _radioWid04() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(children: <Widget>[
        Radio(
            value: GenderType.MALE,
            groupValue: _groupValue,
            activeColor: Colors.green,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('男',
            style: TextStyle(
                color: _groupValue == GenderType.MALE
                    ? Colors.green
                    : Colors.black))
      ]),
      Row(children: <Widget>[
        Radio(
            value: GenderType.FEMALE,
            groupValue: _groupValue,
            activeColor: Colors.red,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('女',
            style: TextStyle(
                color: _groupValue == GenderType.FEMALE
                    ? Colors.red
                    : Colors.black))
      ])
    ]);
  }

  _radioWid05() {
    return Theme(
        data: ThemeData(
            unselectedWidgetColor: Colors.deepPurple,
            disabledColor: Colors.brown),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Row(children: <Widget>[
            Radio(
                value: GenderType.MALE,
                groupValue: _groupValue,
                activeColor: Colors.green,
                onChanged: (val) {
                  print('---onChanged---$val');
                  setState(() => _groupValue = val);
                }),
            Text('男',
                style: TextStyle(
                    color: _groupValue == GenderType.MALE
                        ? Colors.green
                        : Colors.black))
          ]),
          Row(children: <Widget>[
            Radio(
                value: GenderType.FEMALE,
                groupValue: _groupValue,
                activeColor: Colors.red,
                onChanged: (val) {
                  print('---onChanged---$val');
                  setState(() => _groupValue = val);
                }),
            Text('女',
                style: TextStyle(
                    color: _groupValue == GenderType.FEMALE
                        ? Colors.red
                        : Colors.black))
          ]),
          Row(children: <Widget>[
            Radio(
                value: GenderType.FEMALE,
                groupValue: _groupValue,
                onChanged: null),
            Text('不可选中')
          ])
        ]));
  }

  _aceRadioWid01() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      ACERadio(
          value: GenderType.MALE,
          groupValue: _groupValue,
          onChanged: (val) {
            print('---onChanged---$val');
            setState(() => _groupValue = val);
          }),
      ACERadio(
          value: GenderType.FEMALE,
          groupValue: _groupValue,
          onChanged: (val) {
            print('---onChanged---$val');
            setState(() => _groupValue = val);
          }),
    ]);
  }

  _aceRadioWid02() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(children: <Widget>[
        ACERadio(
            value: GenderType.MALE,
            groupValue: _groupValue,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('男')
      ]),
      Row(children: <Widget>[
        ACERadio(
            value: GenderType.FEMALE,
            groupValue: _groupValue,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('女')
      ]),
      Row(children: <Widget>[
        ACERadio(
            value: GenderType.FEMALE, groupValue: _groupValue, onChanged: null),
        Text('不可选中')
      ])
    ]);
  }

  _aceRadioWid03() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(children: <Widget>[
        Text('padded'),
        Container(
            color: Colors.grey.withOpacity(0.4),
            child: ACERadio(
                value: GenderType.MALE,
                groupValue: _groupValue,
                materialTapTargetSize: ACEMaterialTapTargetSize.padded,
                onChanged: (val) => setState(() => _groupValue = val))),
      ]),
      SizedBox(width: 10),
      Row(children: <Widget>[
        Container(
            color: Colors.grey.withOpacity(0.4),
            child: ACERadio(
                value: GenderType.FEMALE,
                groupValue: _groupValue,
                materialTapTargetSize: ACEMaterialTapTargetSize.shrinkWrap,
                onChanged: (val) => setState(() => _groupValue = val))),
        Text('shrinkWrap')
      ]),
      SizedBox(width: 10),
      Row(children: <Widget>[
        Container(
            color: Colors.grey.withOpacity(0.4),
            child: ACERadio(
                value: GenderType.FEMALE,
                groupValue: _groupValue,
                materialTapTargetSize: ACEMaterialTapTargetSize.zero,
                onChanged: null)),
        Text('zero')
      ])
    ]);
  }

  _aceRadioWid04() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(children: <Widget>[
        ACERadio(
            value: GenderType.MALE,
            groupValue: _groupValue,
            activeColor: Colors.green,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('男',
            style: TextStyle(
                color: _groupValue == GenderType.MALE
                    ? Colors.green
                    : Colors.black))
      ]),
      Row(children: <Widget>[
        ACERadio(
            value: GenderType.FEMALE,
            groupValue: _groupValue,
            activeColor: Colors.red,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('女',
            style: TextStyle(
                color: _groupValue == GenderType.FEMALE
                    ? Colors.red
                    : Colors.black))
      ])
    ]);
  }

  _aceRadioWid05() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(children: <Widget>[
        ACERadio(
            value: GenderType.MALE,
            groupValue: _groupValue,
            activeColor: Colors.green,
            unCheckedColor: Colors.deepPurple,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('男',
            style: TextStyle(
                color: _groupValue == GenderType.MALE
                    ? Colors.green
                    : Colors.black))
      ]),
      Row(children: <Widget>[
        ACERadio(
            value: GenderType.FEMALE,
            groupValue: _groupValue,
            activeColor: Colors.red,
            unCheckedColor: Colors.deepPurple,
            onChanged: (val) {
              print('---onChanged---$val');
              setState(() => _groupValue = val);
            }),
        Text('女',
            style: TextStyle(
                color: _groupValue == GenderType.FEMALE
                    ? Colors.red
                    : Colors.black))
      ]),
      Row(children: <Widget>[
        ACERadio(
            value: GenderType.FEMALE,
            groupValue: _groupValue,
            disabledColor: Colors.brown,
            unCheckedColor: Colors.deepPurple,
            onChanged: null),
        Text('不可选中')
      ])
    ]);
  }

  _aceRadioWid06() {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ACERadio(
            radioSize: 6.0,
            value: SizeType.SIZE_6,
            groupValue: _groupSizeValue,
            onChanged: (val) => setState(() => _groupSizeValue = val)),
        Text('Size:6.0*6.0')
      ]),
      SizedBox(height: 8.0),
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ACERadio(
            radioSize: 8.0,
            value: SizeType.SIZE_8,
            groupValue: _groupSizeValue,
            onChanged: (val) => setState(() => _groupSizeValue = val)),
        Text('Size:8.0*8.0')
      ]),
      SizedBox(height: 8.0),
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ACERadio(
            radioSize: 10.0,
            value: SizeType.SIZE_10,
            groupValue: _groupSizeValue,
            onChanged: (val) => setState(() => _groupSizeValue = val)),
        Text('Size:10.0*10.0')
      ]),
      SizedBox(height: 8.0),
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ACERadio(
            radioSize: 14.0,
            value: SizeType.SIZE_14,
            groupValue: _groupSizeValue,
            onChanged: (val) => setState(() => _groupSizeValue = val)),
        Text('Size:14.0*14.0')
      ]),
      SizedBox(height: 8.0),
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ACERadio(
            radioSize: 18.0,
            value: SizeType.SIZE_18,
            groupValue: _groupSizeValue,
            onChanged: (val) => setState(() => _groupSizeValue = val)),
        Text('Size:18.0*18.0')
      ]),
    ]);
  }
}
