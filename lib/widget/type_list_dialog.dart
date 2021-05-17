import 'package:flutter/material.dart';

bool isAllChecked = false;
List levelBackList = [];

class TypeListDialog extends Dialog {
  static const allType = 0;
  static const levelType = 1;
  final List data;
  final Function state;
  final Function onSelectEvent;

  TypeListDialog(
      {Key key, this.data, @required this.state, @required this.onSelectEvent});

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _itemTag(allType, null, 0),
                          SizedBox(height: 15.0),
                          _wrapListTag(levelType, this.data),
                          SizedBox(height: 10.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _bottomButton(0, context),
                                SizedBox(width: 15.0),
                                _bottomButton(1, context)
                              ])
                        ])))));
  }

  _itemTag(type, list, index) {
    bool _isChecked = false;
    if (allType == type) {
      _isChecked = isAllChecked;
    } else {
      _isChecked = list[index].isChecked;
    }
    return InkWell(
        key: GlobalKey(),
        child: Container(
            decoration: BoxDecoration(
                color: _isChecked ? Colors.deepOrange : Colors.white,
                border: Border.all(
                    color: _isChecked ? Colors.deepOrange : Colors.black),
                borderRadius: BorderRadius.circular(18.0)),
            child: Padding(
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 16.0, right: 16.0),
                child: Text(type == allType ? '全部' : list[index].name,
                    style: TextStyle(
                        color: _isChecked ? Colors.white : Colors.black,
                        fontSize: 16.0)))),
        onTap: () {
          if (type == levelType) {
            List.generate(data.length, (curIndex) {
              if (index == curIndex) {
                data[curIndex].isChecked = !data[curIndex].isChecked;
                if (data[curIndex].isChecked) {
                  levelBackList.add(data[curIndex].name);
                }
              }
            });
            state(() {});
          }
        });
  }

  _wrapListTag(type, tagList) {
    List<Widget> tagWid = [];
    if (tagList != null && tagList.length > 0) {
      for (int i = 0; i < tagList.length; i++) {
        tagWid.add(_itemTag(type, tagList, i));
      }
    } else {
      tagWid.add(Container(width: 0.0, height: 0.0));
    }
    return Wrap(children: tagWid, spacing: 15.0, runSpacing: 15.0);
  }

  _bottomButton(type, context) {
    return InkWell(
        child: Container(
            decoration: BoxDecoration(
                color: type == 0 ? Colors.black : Colors.deepOrange,
                border: Border.all(
                    color: type == 0 ? Colors.black : Colors.deepOrange),
                borderRadius: BorderRadius.circular(6.0)),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                child: Text(type == 0 ? 'Cancel' : 'Sure',
                    style: TextStyle(color: Colors.white, fontSize: 16.0)))),
        onTap: () {
          if (type == 0) {
            Navigator.pop(context);
          } else {
            onSelectEvent(levelBackList, ['a', 'b', 'c']);
            Navigator.pop(context);
          }
        });
  }
}

class TypeBean {
  bool _isChecked = false;

  bool get isChecked => this._isChecked;

  set isChecked(bool isChecked) => this._isChecked = isChecked;

  String _name = '';

  String get name => this._name;

  set name(String name) => this._name = name;

  TypeBean(this._name, this._isChecked);
}
