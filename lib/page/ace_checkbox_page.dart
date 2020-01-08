import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_checkbox.dart';

class ACECheckBoxPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACECheckBoxState();
}

class _ACECheckBoxState extends State<ACECheckBoxPage> {
  bool state = false, aceState = false;
  var _triState, _triAceState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('ACECheckBox')),
            body: ListView(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('CheckBox:')),
                    _itemCheckBox01(),
                    _itemCheckBox02(),
                    _itemCheckBox03(),
                    _itemCheckBox04()
                  ]),
              Divider(height: 1.0, color: Colors.grey),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        child: Text('ACECheckBox:')),
                    Column(children: <Widget>[
                      Row(children: <Widget>[
                        _itemACECheckBox01(),
                        _itemACECheckBox02(),
                        _itemACECheckBox03(),
                        _itemACECheckBox04()
                      ]),
                      Row(children: <Widget>[
                        _itemACECheckBox05(),
                        _itemACECheckBox06(),
                        _itemACECheckBox07(),
                        _itemACECheckBox08()
                      ]),
                      Row(children: <Widget>[
                        _itemACECheckBox09(),
                        _itemACECheckBox10(),
                        _itemACECheckBox11(),
                        _itemACECheckBox12()
                      ]),
                      Row(children: <Widget>[
                        _itemACECheckBox13(),
                        _itemACECheckBox14(),
                        _itemACECheckBox15(),
                        _itemACECheckBox16()
                      ]),
                      Row(children: <Widget>[
                        _itemACECheckBox17(),
                        _itemACECheckBox18(),
                        _itemACECheckBox19(),
                        _itemACECheckBox20()
                      ])
                    ])
                  ])
            ])));
  }

  _itemCheckBox01() {
    return Checkbox(
        value: state, onChanged: (value) => setState(() => state = value));
  }

  _itemCheckBox02() {
    return Checkbox(
        value: state,
        checkColor: Colors.purpleAccent.withOpacity(0.7),
        onChanged: (value) => setState(() => state = value));
  }

  _itemCheckBox03() {
    return Checkbox(
        value: state,
        activeColor: Colors.teal.withOpacity(0.3),
        checkColor: Colors.purpleAccent.withOpacity(0.7),
        onChanged: (value) => setState(() => state = value));
  }

  _itemCheckBox04() {
    return Checkbox(
        value: _triState == null ? _triState : state,
        tristate: true,
        activeColor: Colors.teal.withOpacity(0.3),
        checkColor: Colors.purpleAccent.withOpacity(0.7),
        onChanged: (value) => setState(() {
              if (value == null) {
                _triState = value;
              } else {
                _triState = '';
                state = value;
              }
            }));
  }

  _itemACECheckBox01() {
    return ACECheckbox(
        value: aceState,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox02() {
    return ACECheckbox(
        value: aceState,
        checkColor: Colors.red.withOpacity(0.7),
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox03() {
    return ACECheckbox(
        value: aceState,
        activeColor: Colors.indigoAccent.withOpacity(0.3),
        checkColor: Colors.red.withOpacity(0.7),
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox04() {
    return ACECheckbox(
        value: _triAceState == null ? _triAceState : aceState,
        tristate: true,
        activeColor: Colors.indigoAccent.withOpacity(0.7),
        checkColor: Colors.red.withOpacity(0.4),
        onChanged: (value) {
          setState(() {
            if (value == null) {
              _triAceState = value;
            } else {
              _triAceState = '';
              aceState = value;
            }
          });
        });
  }

  _itemACECheckBox05() {
    return ACECheckbox(
        value: aceState,
        unCheckColor: Colors.amberAccent,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox06() {
    return ACECheckbox(
        value: aceState,
        checkColor: Colors.red.withOpacity(0.7),
        unCheckColor: Colors.amberAccent,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox07() {
    return ACECheckbox(
        value: aceState,
        activeColor: Colors.indigoAccent.withOpacity(0.3),
        checkColor: Colors.red.withOpacity(0.7),
        unCheckColor: Colors.amberAccent,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox08() {
    return ACECheckbox(
        value: _triAceState == null ? _triAceState : aceState,
        tristate: true,
        activeColor: Colors.indigoAccent.withOpacity(0.7),
        checkColor: Colors.red.withOpacity(0.4),
        unCheckColor: Colors.amberAccent,
        onChanged: (value) {
          setState(() {
            if (value == null) {
              _triAceState = value;
            } else {
              _triAceState = '';
              aceState = value;
            }
          });
        });
  }

  _itemACECheckBox09() {
    return ACECheckbox(
        value: aceState,
        unCheckColor: Colors.amberAccent,
        type: ACECheckBoxType.circle,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox10() {
    return ACECheckbox(
        value: aceState,
        checkColor: Colors.red.withOpacity(0.7),
        unCheckColor: Colors.amberAccent,
        type: ACECheckBoxType.circle,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox11() {
    return ACECheckbox(
        value: aceState,
        activeColor: Colors.indigoAccent.withOpacity(0.3),
        checkColor: Colors.red.withOpacity(0.7),
        unCheckColor: Colors.amberAccent,
        type: ACECheckBoxType.circle,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox12() {
    return ACECheckbox(
        value: _triAceState == null ? _triAceState : aceState,
        tristate: true,
        activeColor: Colors.indigoAccent.withOpacity(0.7),
        checkColor: Colors.red.withOpacity(0.4),
        unCheckColor: Colors.amberAccent,
        type: ACECheckBoxType.circle,
        onChanged: (value) {
          setState(() {
            if (value == null) {
              _triAceState = value;
            } else {
              _triAceState = '';
              aceState = value;
            }
          });
        });
  }

  _itemACECheckBox13() {
    return ACECheckbox(
        value: aceState,
        width: 10.0,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox14() {
    return ACECheckbox(
        value: aceState,
        checkColor: Colors.red.withOpacity(0.7),
        width: 18.0,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox15() {
    return ACECheckbox(
        value: aceState,
        activeColor: Colors.indigoAccent.withOpacity(0.3),
        checkColor: Colors.red.withOpacity(0.7),
        width: 28.0,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox16() {
    return ACECheckbox(
        value: _triAceState == null ? _triAceState : aceState,
        tristate: true,
        activeColor: Colors.indigoAccent.withOpacity(0.7),
        checkColor: Colors.red.withOpacity(0.4),
        type: ACECheckBoxType.normal,
        width: 38.0,
        onChanged: (value) {
          setState(() {
            if (value == null) {
              _triAceState = value;
            } else {
              _triAceState = '';
              aceState = value;
            }
          });
        });
  }

  _itemACECheckBox17() {
    return ACECheckbox(
        value: aceState,
        unCheckColor: Colors.amberAccent,
        type: ACECheckBoxType.circle,
        width: 10.0,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox18() {
    return ACECheckbox(
        value: aceState,
        checkColor: Colors.red.withOpacity(0.7),
        unCheckColor: Colors.amberAccent,
        type: ACECheckBoxType.circle,
        width: 18.0,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox19() {
    return ACECheckbox(
        value: aceState,
        activeColor: Colors.indigoAccent.withOpacity(0.3),
        checkColor: Colors.red.withOpacity(0.7),
        unCheckColor: Colors.amberAccent,
        type: ACECheckBoxType.circle,
        width: 28.0,
        onChanged: (value) => setState(() => aceState = value));
  }

  _itemACECheckBox20() {
    return ACECheckbox(
        value: _triAceState == null ? _triAceState : aceState,
        tristate: true,
        activeColor: Colors.indigoAccent.withOpacity(0.7),
        checkColor: Colors.red.withOpacity(0.4),
        unCheckColor: Colors.amberAccent,
        type: ACECheckBoxType.circle,
        width: 38.0,
        onChanged: (value) {
          setState(() {
            if (value == null) {
              _triAceState = value;
            } else {
              _triAceState = '';
              aceState = value;
            }
          });
        });
  }
}
