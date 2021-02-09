import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_app/menu/bill_type.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/name_utils.dart';

const PI = 3.1415926;
const _pieRadius = 110.0;

class ACEPiePainter extends CustomPainter {
  List<Map<BillType, double>> _listData = [];
  var _rotateAngle = 0.0;
  double _sum = 0.0;
  String _subName = '';

  ACEPiePainter(this._listData, this._rotateAngle);

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = 0.0, sweepAngle = 0.0;
    Rect _circle = Rect.fromCircle(
        center: Offset(size.width * 0.5, size.height * 0.5),
        radius: _pieRadius);
    Paint _paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;
    ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.left,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        fontSize: 14))
      ..pushStyle(ui.TextStyle(color: Colors.white));
    ParagraphConstraints _paragraph =
        ParagraphConstraints(width: size.width * 0.5);
    _sumData();
    if (_rotateAngle == null) {
      _rotateAngle = 0.0;
    }
    if (_listData != null) {
      for (int i = 0; i < _listData.length; i++) {
        startAngle += sweepAngle;
        sweepAngle = _listData[i].values.first * 2 * PI / _sum;
        canvas.drawArc(_circle, startAngle + _rotateAngle, sweepAngle, true,
            _paint..color = _subPaint(_listData[i].keys.first));

        if (sweepAngle >= PI / 6) {
          canvas.translate(size.width * 0.5, size.height * 0.5);
          canvas.rotate(startAngle + sweepAngle * 0.5 + _rotateAngle);
          Paragraph paragraph = (_pb..addText(_subName)).build()
            ..layout(_paragraph);
          canvas.drawParagraph(
              paragraph, Offset(50.0, 0.0 - paragraph.height * 0.5));
          canvas.rotate(-startAngle - sweepAngle * 0.5 - _rotateAngle);
          canvas.translate(-size.width * 0.5, -size.height * 0.5);
        }
      }
    }
    _sum = 0.0;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _sumData() {
    if (_listData != null) {
      for (int i = 0; i < _listData.length; i++) {
        print(
            '----${_listData[i].values}---${_listData[i].values.first}---${_listData[i].keys}---${_listData[i].keys.first}');
        _sum += _listData[i].values.first;
        print('---$_sum---');
      }
    }
  }

  _subPaint(type) {
    Color _color;
    switch (type) {
      case BillType.BILL_PAR_NORMAL:
        _color = ColorUtils.subNormal;
        _subName = NameUtils.billNormal;
        break;
      case BillType.BILL_PAR_FIT:
        _color = ColorUtils.subFit;
        _subName = NameUtils.billFit;
        break;
      case BillType.BILL_PAR_BABY:
        _color = ColorUtils.subBaby;
        _subName = NameUtils.billBaby;
        break;
      case BillType.BILL_PAR_BUSINESS:
        _color = ColorUtils.subBusiness;
        _subName = NameUtils.billBusiness;
        break;
      case BillType.BILL_PAR_CAR:
        _color = ColorUtils.subCar;
        _subName = NameUtils.billCar;
        break;
      case BillType.BILL_PAR_MARRY:
        _color = ColorUtils.subMarry;
        _subName = NameUtils.billMarry;
        break;
      case BillType.BILL_PAR_PET:
        _color = ColorUtils.subPet;
        _subName = NameUtils.billPet;
        break;
      case BillType.BILL_PAR_STUDY:
        _color = ColorUtils.subStudy;
        _subName = NameUtils.billStudy;
        break;
      case BillType.BILL_PAR_MONEY:
        _color = ColorUtils.subIncome;
        _subName = NameUtils.billMoney;
        break;
      case BillType.BILL_PAR_OTHER:
        _color = ColorUtils.subOther;
        _subName = NameUtils.billOther;
        break;
    }
    return _color;
  }
}
