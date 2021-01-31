import 'package:flutter_app/utils/constant_utils.dart';

class BillBean {
  String billName;
  String billExp;
  String billInc;
  String billCount;
  String createTime;
  String updateTime;

  BillBean();

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    if (billName != null) {
      map[ConstantUtils.COL_BILLNAME] = billName;
    }
    if (billExp != null) {
      map[ConstantUtils.COL_BILLEXP] = billExp;
    }
    if (billInc != null) {
      map[ConstantUtils.COL_BILLINC] = billInc;
    }
    if (billCount != null) {
      map[ConstantUtils.COL_BILLCOUNT] = billCount;
    }
    if (createTime != null) {
      map[ConstantUtils.COL_CREATETIME] = createTime;
    }
    if (updateTime != null) {
      map[ConstantUtils.COL_UPDATETIME] = updateTime;
    }
    return map;
  }

  BillBean.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      billName = map[ConstantUtils.COL_BILLNAME];
      billExp = map[ConstantUtils.COL_BILLEXP];
      billInc = map[ConstantUtils.COL_BILLINC];
      billCount = map[ConstantUtils.COL_BILLCOUNT];
      createTime = map[ConstantUtils.COL_CREATETIME];
      updateTime = map[ConstantUtils.COL_UPDATETIME];
    }
  }
}
