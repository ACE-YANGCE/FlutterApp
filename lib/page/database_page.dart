import 'package:flutter/material.dart';
import 'package:flutter_app/bean/bill_bean.dart';
import 'dart:convert';
import 'package:flutter_app/manager/bill_sql_manager.dart';
import 'package:flutter_app/utils/constant_utils.dart';

class DatabasePage extends StatefulWidget {
  @override
  _DatabasePageState createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  BillSQLManager sqlManager;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('DBManager PAGE')),
            body: ListView(children: <Widget>[
              _itemWid('初始化数据库', 0, Colors.pink.withOpacity(0.5)),
              _itemWid('插入1条数据', 1, Colors.brown.withOpacity(0.5)),
              _itemWid('追加5条数据', 2, Colors.blue.withOpacity(0.5)),
              _itemWid('查询数据条数', 3, Colors.brown.withOpacity(0.5)),
              _itemWid('查询所有数据列表', 4, Colors.red.withOpacity(0.5)),
              _itemWid('查询前3条数据列表', 5, Colors.brown.withOpacity(0.5)),
              _itemWid('以3条为一页，查询第一页数据', 6, Colors.yellow.withOpacity(0.5)),
              _itemWid('以3条为一页，查询第二页数据', 7, Colors.brown.withOpacity(0.5)),
              _itemWid('更新1条数据', 8, Colors.teal.withOpacity(0.5)),
              _itemWid('删除1条数据', 9, Colors.brown.withOpacity(0.5)),
              _itemWid('删除所有数据', 10, Colors.orange.withOpacity(0.5)),
              _itemWid('关闭数据库', 11, Colors.brown.withOpacity(0.5))
            ])));
  }

  _itemWid(text, index, color) {
    return GestureDetector(
        child: Container(
            color: color,
            height: 60,
            child: Center(
                child: Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 16)))),
        onTap: () => _itemClick(index));
  }

  _itemClick(index) {
    switch (index) {
      case 0:
        sqlManager.initDB();
        break;
      case 1:
        sqlManager.insertMap(
            ConstantUtils.TABLE_BILL,
            Map<String, dynamic>.from({
              'billName': '早餐',
              'billExp': '10.0',
              'billInc': '0.0',
              'billCount': '0',
              'createTime': DateTime.now().millisecondsSinceEpoch,
              'updateTime': DateTime.now().millisecondsSinceEpoch
            }));
        break;
      case 2:
        for (int i = 0; i < 5; i++) {
          sqlManager.insertMap(
              ConstantUtils.TABLE_BILL,
              Map<String, dynamic>.from({
                'billName': '账单${(i + 1)}',
                'billExp': '${10 * (i + 1)}',
                'billInc': '${20 * (i + 1)}',
                'billCount': '0',
                'createTime': DateTime.now().millisecondsSinceEpoch,
                'updateTime': DateTime.now().millisecondsSinceEpoch
              }));
        }
        break;
      case 3:
        sqlManager
            .queryCount(ConstantUtils.TABLE_BILL)
            .then((val) => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return UnconstrainedBox(
                      constrainedAxis: Axis.vertical,
                      child: SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: AlertDialog(content: Text('$val'))));
                }));
        break;
      case 4:
        sqlManager
            .queryList(ConstantUtils.TABLE_BILL)
            .then((val) => _showDialog(val));
        break;
      case 5:
        sqlManager
            .queryList(ConstantUtils.TABLE_BILL, count: 3)
            .then((val) => _showDialog(val));
        break;
      case 6:
        sqlManager
            .queryListByPage(ConstantUtils.TABLE_BILL, 3, 1)
            .then((val) => _showDialog(val));
        break;
      case 7:
        sqlManager
            .queryListByPage(ConstantUtils.TABLE_BILL, 3, 2)
            .then((val) => _showDialog(val));
        break;
      case 8:
        BillBean billBean = BillBean();
        billBean.billName = '更新标题';
        billBean.billExp = "100.0";
        billBean.billInc = "80.0";
        billBean.createTime = DateTime.now().millisecondsSinceEpoch.toString();
        billBean.updateTime = DateTime.now().millisecondsSinceEpoch.toString();
        billBean.billCount = '90';
        print('---map---${billBean.toMap()}');
        sqlManager.insertByMap(ConstantUtils.TABLE_BILL, billBean.toMap());
        sqlManager
            .queryList(ConstantUtils.TABLE_BILL)
            .then((val) => _showDialog(val));
        break;
      case 9:
        sqlManager.deleteByParams(
            ConstantUtils.TABLE_BILL, ConstantUtils.COL_BILLNAME, '更新标题');
        sqlManager
            .queryList(ConstantUtils.TABLE_BILL)
            .then((val) => _showDialog(val));
        break;
      case 10:
        sqlManager
            .deleteAll(ConstantUtils.TABLE_BILL)
            .then((val) => _showCountDialog(val));
        break;
      case 11:
        sqlManager.closeDB();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    sqlManager = BillSQLManager.getInstance();
    // sqlManager.initDB();
  }

  _showDialog(List listData) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Container(
                  width: double.maxFinite,
                  child: ListView.builder(
                      itemCount: listData.length,
                      physics: ScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('${listData[index].toString()}');
                      })));
        });
  }

  _showCountDialog(val) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return UnconstrainedBox(
              constrainedAxis: Axis.vertical,
              child: SizedBox(
                  width: 180.0,
                  height: 180.0,
                  child: AlertDialog(content: Text('$val'))));
        });
  }
}
