import 'package:flutter/material.dart';
import 'package:flutter_app/menu/bill_type.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/name_utils.dart';
import 'package:flutter_app/widget/ace_pie_widget.dart';

class ACEPiePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ACEPiePageState();
}

class _ACEPiePageState extends State<ACEPiePage> {
  List<Map<BillType, double>> _listData = [];

  @override
  void initState() {
    super.initState();
    _getListData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('轻 · 账单'), backgroundColor: Colors.teal),
            body: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    children: <Widget>[_chartWid(), _listWid(), _billBtn()]))));
  }

  _chartWid() {
    return Container(
        height: 250,
        color: Colors.grey.withOpacity(0.2),
        child: Row(children: <Widget>[
          Column(children: <Widget>[
            _itemChartWid(BillType.BILL_PAR_NORMAL),
            _itemChartWid(BillType.BILL_PAR_FIT),
            _itemChartWid(BillType.BILL_PAR_MARRY),
            _itemChartWid(BillType.BILL_PAR_CAR),
            _itemChartWid(BillType.BILL_PAR_BABY)
          ]),
          Expanded(child: ACEPieWidget(_listData), flex: 1),
          Column(children: <Widget>[
            _itemChartWid(BillType.BILL_PAR_PET),
            _itemChartWid(BillType.BILL_PAR_STUDY),
            _itemChartWid(BillType.BILL_PAR_BUSINESS),
            _itemChartWid(BillType.BILL_PAR_MONEY),
            _itemChartWid(BillType.BILL_PAR_OTHER)
          ])
        ]));
  }

  _listWid() {
    return Expanded(
        child: Container(
            child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return _itemBill(index);
                })),
        flex: 1);
  }

  _itemBill(index) {
    return Container(
        height: 50,
        color: index % 2 == 1
            ? Colors.grey.withOpacity(0.2)
            : Colors.yellow.withOpacity(0.2));
  }

  _billBtn() {
    return GestureDetector(
        child: Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.6),
                borderRadius: BorderRadius.circular((25.0))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5.0),
                      child: Image.asset('images/icon_logo.png',
                          color: Colors.white)),
                  Text('记一笔', style: TextStyle(color: Colors.white))
                ])),
        onTap: () {});
  }

  _itemChartWid(type) {
    Color _color;
    String _text;
    switch (type) {
      case BillType.BILL_PAR_NORMAL:
        _color = ColorUtils.subNormal;
        _text = NameUtils.billNormal;
        break;
      case BillType.BILL_PAR_FIT:
        _color = ColorUtils.subFit;
        _text = NameUtils.billFit;
        break;
      case BillType.BILL_PAR_MARRY:
        _color = ColorUtils.subMarry;
        _text = NameUtils.billMarry;
        break;
      case BillType.BILL_PAR_CAR:
        _color = ColorUtils.subCar;
        _text = NameUtils.billCar;
        break;
      case BillType.BILL_PAR_BABY:
        _color = ColorUtils.subBaby;
        _text = NameUtils.billBaby;
        break;
      case BillType.BILL_PAR_PET:
        _color = ColorUtils.subPet;
        _text = NameUtils.billPet;
        break;
      case BillType.BILL_PAR_STUDY:
        _color = ColorUtils.subStudy;
        _text = NameUtils.billStudy;
        break;
      case BillType.BILL_PAR_BUSINESS:
        _color = ColorUtils.subBusiness;
        _text = NameUtils.billBusiness;
        break;
      case BillType.BILL_PAR_MONEY:
        _color = ColorUtils.subIncome;
        _text = NameUtils.billMoney;
        break;
      case BillType.BILL_PAR_OTHER:
        _color = ColorUtils.subOther;
        _text = NameUtils.billOther;
        break;
    }
    return Container(
        height: 45,
        width: 45,
        margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
        decoration: BoxDecoration(
            color: _color, borderRadius: BorderRadius.circular((25.0))),
        child: Center(
            child: Text(_text,
                style: TextStyle(fontSize: 12, color: Colors.white))));
  }

  _getListData() {
    _listData.clear();
    Map<BillType, double> map01 = Map();
    map01[BillType.BILL_PAR_NORMAL] = 800.67;
    Map<BillType, double> map02 = Map();
    map02[BillType.BILL_PAR_FIT] = 323.4;
    Map<BillType, double> map03 = Map();
    map03[BillType.BILL_PAR_MARRY] = 480;
    Map<BillType, double> map04 = Map();
    map04[BillType.BILL_PAR_CAR] = 1357.9;
    Map<BillType, double> map05 = Map();
    map05[BillType.BILL_PAR_BABY] = 30;
    Map<BillType, double> map06 = Map();
    map06[BillType.BILL_PAR_PET] = 600.78;
    Map<BillType, double> map07 = Map();
    map07[BillType.BILL_PAR_STUDY] = 125.9;
    Map<BillType, double> map08 = Map();
    map08[BillType.BILL_PAR_BUSINESS] = 99;
    Map<BillType, double> map09 = Map();
    map09[BillType.BILL_PAR_MONEY] = 37.5;
    Map<BillType, double> map10 = Map();
    map10[BillType.BILL_PAR_OTHER] = 10;

    _listData.add(map01);
    _listData.add(map02);
    _listData.add(map03);
    _listData.add(map04);
    _listData.add(map05);
    _listData.add(map06);
    _listData.add(map07);
    _listData.add(map08);
    _listData.add(map09);
    _listData.add(map10);
  }
}
