class ConstantUtils {
  static final String DB_NAME = "bill.db";
  static final int DB_VERSION = 1;
  static final String TABLE_BILL = "BILL";
  static final String CREATE_BILL_SQL = "CREATE table BILL("
      "id integer primary key autoincrement, billName TEXT, billExp TEXT,  "
      "billInc TEXT, billCount TEXT,  createTime TEXT, updateTime TEXT )";
  static final String COL_BILLNAME = "billName";
  static final String COL_BILLEXP = "billExp";
  static final String COL_BILLINC = "billInc";
  static final String COL_BILLCOUNT = "billCount";
  static final String COL_CREATETIME = "createTime";
  static final String COL_UPDATETIME = "updateTime";
}
