import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/bill_name_dialog.dart';
import 'package:flutter_app/widget/type_list_dialog.dart';

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => new _DialogPageState();
}

List levelList = [
  TypeBean('A', false),
  TypeBean('B', false),
  TypeBean('C', false),
  TypeBean('D', false),
  TypeBean('EE', false),
  TypeBean('FF', false),
  TypeBean('GG', false),
  TypeBean('HHH', false),
  TypeBean('I_I', false),
  TypeBean('JKL', false),
];

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Dialog Page'), automaticallyImplyLeading: false),
        body: _bodyWid());
  }

  _bodyWid() => ListView(children: <Widget>[
        _itemWid('文本框 & AlertDialog', 0, Colors.pink.withOpacity(0.4)),
        _itemWid('文本框 & 自定义 Dialog', 1, Colors.pinkAccent.withOpacity(0.4)),
        _itemWid('选中状态 & 自定义 Dialog', 2, Colors.green.withOpacity(0.4)),
      ]);

  _itemWid(text, index, color) {
    return Padding(
        child: FlatButton(
            onPressed: () => _itemClick(index),
            child: Text(text, style: TextStyle(color: Colors.white)),
            color: color),
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0));
  }

  _itemClick(index) async {
    switch (index) {
      case 0:
        await _displayTextInputDialog();
        break;
      case 1:
        await _showBillNameDialog();
        break;
      case 2:
        await _showTypeListDialog();
        break;
    }
  }

  Future<void> _showTypeListDialog() async {
    // await showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return TypeListDialog(data: levelList);
    //     });
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (context, state) => TypeListDialog(
                state: state,
                data: levelList,
                onSelectEvent: (list1, list2) {
                  print('list1=$list1, list2=$list2');
                  // Toast.show('list1=$list1, list2=$list2', context,
                  //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                })));
  }

  Future<void> _displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('AlertDialog'),
              content: TextField(
                  onChanged: (value) => setState(() {}),
                  controller: TextEditingController(),
                  decoration:
                      InputDecoration(hintText: "Text Field in Dialog")),
              actions: <Widget>[
                FlatButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('CANCEL'),
                    onPressed: () => setState(() => Navigator.pop(context))),
                FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text('OK'),
                    onPressed: () => setState(() => Navigator.pop(context)))
              ]);
        });
  }

  Future<void> _showBillNameDialog() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BillNameDialog(onCancelEvent: () {
            Navigator.pop(context);
          }, onSureEvent: (name) {
            Navigator.pop(context);
          });
        });
  }
}
