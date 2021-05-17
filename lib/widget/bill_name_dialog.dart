import 'package:flutter/material.dart';

class BillNameDialog extends Dialog {
  final Function onCancelEvent;
  final Function onSureEvent;

  BillNameDialog(
      {Key key, @required this.onCancelEvent, @required this.onSureEvent});

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: Stack(children: [
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 25.0),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text('账单名称', style: TextStyle(fontSize: 16.0)),
                            _nameWid(),
                            Row(children: [
                              Expanded(child: _actionButtons(0)),
                              SizedBox(width: 15.0),
                              Expanded(child: _actionButtons(1))
                            ])
                          ]))))
            ])));
  }

  _nameWid() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 25.0),
        child: TextField(
            controller: TextEditingController(),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                hintText: '创建订单名称',
                hintStyle: TextStyle(fontSize: 14.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Color(0xFFf1efe5))));
  }

  _actionButtons(type) {
    return InkWell(
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: type == 0 ? Color(0xFF1E1E1E) : Colors.deepOrange,
                border: Border.all(
                    color: type == 0 ? Color(0xFF1E1E1E) : Colors.deepOrange),
                borderRadius: BorderRadius.circular(6.0)),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                child: Text(type == 0 ? '取消' : '确认',
                    style: TextStyle(color: Colors.white, fontSize: 15.0)))),
        onTap: () {
          if (type == 0) {
            onCancelEvent();
          } else {
            onSureEvent();
          }
        });
  }
}
