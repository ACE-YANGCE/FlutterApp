abstract class SQLMethod {
  /// 根据SQL插入一条数据
  /// [sql]         插入SQL
  Future<int> insertSQL(String sql);

  /// 根据Map插入一条数据
  /// [tableName]   表名
  /// [map]         插入Map
  Future<int> insertByMap(String tableName, Map<String, dynamic> map);

  /// 根据Map插入一条数据
  /// [tableName]   表名
  /// [json]         插入Json
  Future<int> insertByJson(String tableName, String json);

  /// 根据key-value删除一条数据
  /// [tableName]   表名
  /// [key]         键-ColumnName
  /// [value]       值-ColumnValue
  Future<int> deleteByParams(String tableName, String key, Object value);

  /// 删除表内所有数据
  /// [tableName]   表名
  Future<int> deleteAll(String tableName);

  /// 根据SQL更新数据
  /// [tableName]   表名
  /// [sql]         更新SQL
  updateSQL(String tableName, String sql);

  /// 根据Map更新一条数据
  /// [tableName]   表名
  /// [key]         查询字段key
  /// [value]       查询字段value
  /// [map]         更新Map
  updateByParams(
      String tableName, String key, Object value, Map<String, dynamic> map);

  /// 查询固定数量数据列表
  /// [tableName]   表名
  /// [count]       数量
  /// [orderBy]     升序/降序
  Future<List<Map<String, dynamic>>> queryList(String tableName,
      {int count, String orderBy});

  /// 分页查询数据列表
  /// [tableName]   表名
  /// [orderBy]     升序/降序
  /// [limitCount]  每页数据长度
  /// [pageSize]    当前页码
  Future<List<Map<String, dynamic>>> queryListByPage(
      String tableName, int limitCount, int pageSize,
      {String orderBy});

  /// 关闭数据库
  closeDB();
}
