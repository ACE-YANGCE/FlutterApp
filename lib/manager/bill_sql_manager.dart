import 'package:flutter_app/bean/bill_bean.dart';
import 'package:flutter_app/manager/sql_method.dart';
import 'package:flutter_app/utils/constant_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class BillSQLManager extends SQLMethod {
  static BillSQLManager _instance;
  Database _db;

  static BillSQLManager getInstance() {
    if (_instance == null) {
      _instance = new BillSQLManager();
    }
    return _instance;
  }

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    print('SQLManager.initDB -> databasePath = $databasePath');
    final path = join(databasePath, ConstantUtils.DB_NAME);
    _db = await openDatabase(path,
        version: ConstantUtils.DB_VERSION,
        onCreate: (_db, _) => _db.execute(ConstantUtils.CREATE_BILL_SQL));
    return _db;
  }

  Future<int> insertMap(String tableName, Map<String, dynamic> params) async {
    int count = await _db.insert(tableName, params);
    return count;
  }

  Future<int> queryCount(String tableName) async {
    List<Map<String, dynamic>> list = await _db.query(tableName);
    return list == null ? 0 : list.length;
  }

  @override
  Future<List<Map<String, dynamic>>> queryList(String tableName,
      {int count, String orderBy}) async {
    List<Map<String, dynamic>> list =
        await _db.query(tableName, orderBy: 'updateTime ${orderBy ?? 'DESC'}');
    if (list != null) {
      if (count != null && count > 0) {
        if (count >= list.length) {
          return list;
        } else {
          return list.sublist(0, count);
        }
      } else {
        return list;
      }
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> queryListByPage(
      String tableName, int limitCount, int pageSize,
      {String orderBy}) async {
    List<Map<String, dynamic>> list;
    if (limitCount != null &&
        limitCount >= 0 &&
        pageSize != null &&
        pageSize >= 0) {
      list = await _db.query(tableName,
          limit: limitCount,
          offset: (pageSize - 1) * limitCount,
          orderBy: 'updateTime ${orderBy ?? 'DESC'}');
      return list;
    }
    return null;
  }

  @override
  Future<int> insertByJson(String tableName, String jsonStr) async {
    int result;
    if (json != null) {
      result = await _db.insert(tableName, json.decode(jsonStr));
    }
    return result;
  }

  @override
  Future<int> insertByMap(String tableName, Map<String, dynamic> map) async {
    int result;
    if (map != null) {
      result = await _db.insert(tableName, map);
    }
    return result;
  }

  @override
  Future<int> insertSQL(String sql) async {
    int result = -1;
    if (sql != null) {
      result = await _db.transaction((db) async {
        return result = await db.rawInsert(sql);
      });
    }
    return result;
  }

  Future<int> insertByBill(String tableName, BillBean billBean) async {
    int result;
    if (billBean != null) {
      result = await _db.insert(tableName, billBean.toMap());
    }
    return result;
  }

  @override
  Future<int> deleteAll(String tableName) async {
    return await _db.delete(tableName);
  }

  @override
  Future<int> deleteByParams(String tableName, String key, Object value) async {
    if (key != null) {
      return await _db.delete(tableName, where: '$key=?', whereArgs: [value]);
    } else {
      return -1;
    }
  }

  @override
  updateSQL(String tableName, String sql) async {
    if (sql != null) {
      await _db.transaction((txn) async => await txn.rawUpdate(sql));
    }
  }

  @override
  closeDB() async {
    if (_db != null) {
      await _db.close();
    }
  }

  @override
  updateByParams(String tableName, String key, Object value,
      Map<String, dynamic> map) async {
    if (key != null) {
      return await _db
          .update(tableName, map, where: '$key=?', whereArgs: [value]);
      // return await _db.update(tableName, map, where: key, whereArgs: [value]);
    }
    return null;
  }
}
