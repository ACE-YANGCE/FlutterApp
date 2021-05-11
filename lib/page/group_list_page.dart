import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_checkbox.dart';

class GroupListPage extends StatefulWidget {
  List<CategoryBean> listData = [
    CategoryBean(name: '特别关心', itemList: [
      SubCategoryBean(name: 'A'),
      SubCategoryBean(name: 'B'),
      SubCategoryBean(name: 'C')
    ]),
    CategoryBean(name: '分组一', itemList: [
      SubCategoryBean(name: 'D'),
      SubCategoryBean(name: 'E'),
      SubCategoryBean(name: 'F')
    ]),
    CategoryBean(name: '分组二', itemList: [
      SubCategoryBean(name: 'G'),
      SubCategoryBean(name: 'H'),
      SubCategoryBean(name: 'I')
    ]),
    CategoryBean(name: '分组三'),
    CategoryBean(name: '分组四', itemList: [
      SubCategoryBean(name: 'J'),
      SubCategoryBean(name: 'K'),
      SubCategoryBean(name: 'L')
    ]),
    CategoryBean(name: '分组五'),
    CategoryBean(name: '分组六')
  ];

  @override
  State<StatefulWidget> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('分组列表')),
        body: ListView.builder(
            itemCount: widget.listData.length,
            itemBuilder: (context, index) {
              return GroupItemWidget(widget.listData[index]);
            }));
  }
}

class GroupItemWidget extends StatefulWidget {
  final CategoryBean bean;

  GroupItemWidget(this.bean);

  @override
  State<StatefulWidget> createState() {
    return _GroupItemWidgetState();
  }
}

class _GroupItemWidgetState extends State<GroupItemWidget> {
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Column(children: <Widget>[
          Divider(height: 0.5, color: Colors.blue),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(children: <Widget>[
                Icon(_isExpand ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: Colors.blue),
                _userIcon(false),
                SizedBox(width: 5.0),
                Expanded(
                    child: Text('${widget.bean.name}',
                        style: TextStyle(fontSize: 16.0))),
                _rightCheckBox(widget.bean, 0)
              ])),
          _subCategoryList(widget.bean)
        ]),
        onTap: () {
          _isExpand = !_isExpand;
          setState(() {});
          if (widget.bean.name == '分组五' &&
              (widget.bean.itemList == null ||
                  widget.bean.itemList.length == 0)) {
            widget.bean.itemList = [
              SubCategoryBean(name: 'O'),
              SubCategoryBean(name: 'P'),
              SubCategoryBean(name: 'Q')
            ];
          }
        });
  }

  _subCategoryList(CategoryBean bean) {
    Widget _widget;
    if (!_isExpand ||
        bean == null ||
        bean.itemList == null ||
        bean.itemList.length == 0) {
      _widget = Container();
    } else {
      _widget = ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: bean.itemList.length,
          itemBuilder: (context, index) => Row(children: <Widget>[
                Flexible(child: _subCategoryItem(bean, index))
              ]));
    }
    return _widget;
  }

  _subCategoryItem(CategoryBean bean, index) {
    return InkWell(
        onTap: () {},
        child: Column(children: <Widget>[
          Divider(height: 0.5, color: Colors.deepOrange),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(children: <Widget>[
                SizedBox(width: 40.0),
                _userIcon(true),
                SizedBox(width: 5.0),
                Expanded(child: Text(bean.itemList[index].name ?? 'SubName')),
                _rightCheckBox(bean, 1, subIndex: index)
              ]))
        ]));
  }

  _userIcon(isCircle) {
    double size = isCircle ? 40.0 : 45.0;
    return PhysicalModel(
        color: Colors.transparent,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Container(
            width: size,
            height: size,
            child: Image.asset(
                isCircle ? 'images/icon_qq.png' : 'images/icon_hzw01.jpg')));
  }

  _rightCheckBox(bean, type, {subIndex}) {
    bool _isChecked =
        type == 0 ? bean.isChecked : bean.itemList[subIndex].isChecked;
    return ACECheckbox(
        value: _isChecked,
        type: ACECheckBoxType.circle,
        unCheckColor: Colors.blue,
        onChanged: (value) {
          setState(() => _isChecked = value);
          if (type == 0) {
            bean.isChecked = _isChecked;
            List.generate(bean.itemList.length,
                (index) => bean.itemList[index].isChecked = _isChecked);
          } else {
            bean.itemList[subIndex].isChecked = _isChecked;
            int checkedSize = 0;
            List.generate(bean.itemList.length, (index) {
              if (bean.itemList[index].isChecked == false) {
                bean.isChecked = false;
              } else {
                checkedSize += 1;
              }
              if (checkedSize == bean.itemList.length) {
                bean.isChecked = true;
              }
            });
          }
        });
  }
}

class CategoryBean {
  String name;
  String url;
  bool _isChecked = false;
  List<SubCategoryBean> itemList;

  bool get isChecked => _isChecked ?? false;

  set isChecked(bool value) => _isChecked = value;

  CategoryBean({this.name, this.url, this.itemList});
}

class SubCategoryBean {
  String name;
  String url;
  bool _isChecked = false;

  SubCategoryBean({this.name, this.url});

  bool get isChecked => _isChecked ?? false;

  set isChecked(bool value) => _isChecked = value;
}
