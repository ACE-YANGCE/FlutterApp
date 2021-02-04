import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/ace_pie_painter.dart';
import 'package:flutter_app/menu/bill_type.dart';

class ACEPieWidget extends StatelessWidget {
  final List<Map<BillType, double>> listData;

  ACEPieWidget(this.listData);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(painter: ACEPiePainter(this.listData)));
  }
}
