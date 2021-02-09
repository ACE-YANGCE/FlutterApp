import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/ace_pie_painter.dart';
import 'package:flutter_app/gesture/ace_pie_gesture_recognizer.dart';
import 'package:flutter_app/menu/bill_type.dart';

class ACEPieWidget extends StatefulWidget {
  final List<Map<BillType, double>> listData;

  ACEPieWidget(this.listData);

  @override
  State<StatefulWidget> createState() => _ACEPieWidgetState();
}

class _ACEPieWidgetState extends State<ACEPieWidget> {
  Offset _startOffset, _updateOffset, _centerOffset;
  GlobalKey _key = GlobalKey();
  var rotateAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: RawGestureDetector(
            child: CustomPaint(
                key: _key,
                painter: ACEPiePainter(widget.listData, this.rotateAngle)),
            gestures: <Type, GestureRecognizerFactory>{
              ACEPieGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<ACEPieGestureRecognizer>(
                      () => ACEPieGestureRecognizer(),
                      (ACEPieGestureRecognizer gesture) {
                gesture.onDown = (detail) {
                  RenderBox box = _key.currentContext.findRenderObject();
                  Offset offset = box.localToGlobal(Offset.zero);
                  _centerOffset = Offset(offset.dx + box.size.width * 0.5,
                      offset.dy + box.size.height * 0.5);
                  _startOffset = detail.globalPosition;
                };
                gesture.onUpdate = (detail) {
                  _updateOffset = detail.globalPosition;
                  setState(() {
                    rotateAngle += _rotateAngle();
                  });
                  _startOffset = _updateOffset;
                };
                gesture.onEnd = (detail) {
                  print(
                      '---onEnd---$detail---${detail.primaryVelocity}---${detail.velocity}---${detail.velocity.pixelsPerSecond}');
                };
              })
            }));
  }

  _rotateAngle() {
    var gestureDirection = 1;
    if (_startOffset.dy < _centerOffset.dy) {
      gestureDirection = -1;
    } else {
      gestureDirection = 1;
    }
    var _updateAngle = gestureDirection *
        _angle(_updateOffset, Offset(_centerOffset.dx + 100, _centerOffset.dy),
            _centerOffset);
    if (_updateOffset.dy < _centerOffset.dy) {
      gestureDirection = -1;
    } else {
      gestureDirection = 1;
    }
    var _startAngle = gestureDirection *
        _angle(_startOffset, Offset(_centerOffset.dx + 100, _centerOffset.dy),
            _centerOffset);
    return (_updateAngle - _startAngle);
  }

  _angle(_aPoint, _bPoint, _oPoint) {
    var _oALen =
        sqrt(pow(_aPoint.dx - _oPoint.dx, 2) + pow(_aPoint.dy - _oPoint.dy, 2));
    var _oBLen =
        sqrt(pow(_bPoint.dx - _oPoint.dx, 2) + pow(_bPoint.dy - _oPoint.dy, 2));
    var _aBLen =
        sqrt(pow(_aPoint.dx - _bPoint.dx, 2) + pow(_aPoint.dy - _bPoint.dy, 2));
    var _cosAngle = (pow(_oALen, 2) + pow(_oBLen, 2) - pow(_aBLen, 2)) /
        (2 * _oALen * _oBLen);
    return acos(_cosAngle);
  }
}
