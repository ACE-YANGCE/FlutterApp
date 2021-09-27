import 'dart:ui';

import 'package:flutter/material.dart';

const _kCommonWidth = 15.0;

class CopyrightPainter extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 1.5
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBorder(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _drawBorder(canvas, size) {
    canvas.drawLine(Offset(_kCommonWidth, _kCommonWidth),
        Offset(_kCommonWidth * 2, _kCommonWidth), _paint);
    canvas.drawLine(Offset(size.width - _kCommonWidth, _kCommonWidth),
        Offset(size.width - _kCommonWidth * 2, _kCommonWidth), _paint);
    canvas.drawLine(Offset(_kCommonWidth, size.height - _kCommonWidth),
        Offset(_kCommonWidth * 2, size.height - _kCommonWidth), _paint);
    canvas.drawLine(
        Offset(size.width - _kCommonWidth, size.height - _kCommonWidth),
        Offset(size.width - _kCommonWidth * 2, size.height - _kCommonWidth),
        _paint);
    canvas.drawLine(Offset(_kCommonWidth, _kCommonWidth),
        Offset(_kCommonWidth, _kCommonWidth * 2), _paint);
    canvas.drawLine(Offset(size.width - _kCommonWidth, _kCommonWidth),
        Offset(size.width - _kCommonWidth, _kCommonWidth * 2), _paint);
    canvas.drawLine(Offset(_kCommonWidth, size.height - _kCommonWidth),
        Offset(_kCommonWidth, size.height - _kCommonWidth * 2), _paint);
    canvas.drawLine(
        Offset(size.width - _kCommonWidth, size.height - _kCommonWidth),
        Offset(size.width - _kCommonWidth, size.height - _kCommonWidth * 2),
        _paint);
    canvas.drawLine(Offset(_kCommonWidth, _kCommonWidth * 2),
        Offset(size.width - _kCommonWidth, _kCommonWidth * 2), _paint);
    canvas.drawLine(
        Offset(_kCommonWidth, size.height - _kCommonWidth * 2),
        Offset(size.width - _kCommonWidth, size.height - _kCommonWidth * 2),
        _paint);
    canvas.drawLine(Offset(_kCommonWidth * 2, _kCommonWidth),
        Offset(_kCommonWidth * 2, size.height - _kCommonWidth), _paint);
    canvas.drawLine(
        Offset(size.width - _kCommonWidth * 2, _kCommonWidth),
        Offset(size.width - _kCommonWidth * 2, size.height - _kCommonWidth),
        _paint);
    canvas.drawRect(
        Rect.fromLTRB(
            _kCommonWidth * 2 + 8.0,
            _kCommonWidth * 2 + 8.0,
            size.width - _kCommonWidth * 2 - 8.0,
            size.height - _kCommonWidth * 2 - 8.0),
        _paint);
  }
}
