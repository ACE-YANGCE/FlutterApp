import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const double _kProHeight = 40.0;
const double _kProStrokeWidth = 0.5;
const double _kProSpaceWidth = 12.0;
const double _kProPaddingWidth = 10.0;
const Color _kProLeftColor = Colors.red;
const Color _kProRightColor = Colors.blue;

class ACEProgressPainter extends CustomPainter {
  final double leftProgress;
  final double height, strokeWidth, spaceWidth;
  final Color leftColor, rightColor, leftTextColor, rightTextColor;
  final bool isFill;
  final String leftText, rightText;

  ACEProgressPainter(this.leftProgress,
      {this.height,
      this.spaceWidth,
      this.strokeWidth,
      this.isFill,
      this.leftColor,
      this.rightColor,
      this.leftTextColor,
      this.rightTextColor,
      this.leftText,
      this.rightText});

  Paint _paint = Paint()
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round;

  double _height,
      _strokeWidth,
      _spaceWidth,
      _leftTextWidth,
      _rightStartWidth,
      _rightTextWidth;

  @override
  void paint(Canvas canvas, Size size) {
    _height = (height == null || height <= 0.0 || height > size.height)
        ? _kProHeight
        : height;
    _strokeWidth = (strokeWidth == null ||
            strokeWidth <= 0.0 ||
            strokeWidth >= size.width * 0.5 ||
            (isFill != null && isFill == true))
        ? _kProStrokeWidth
        : strokeWidth;
    _spaceWidth = (spaceWidth == null ||
            spaceWidth <= 0.0 ||
            spaceWidth >= size.width * 0.5)
        ? _kProSpaceWidth
        : spaceWidth;
    _paint = _paint
      ..strokeWidth = (isFill == null || isFill == false) ? _strokeWidth : 0.5
      ..style = (isFill == null || isFill == false)
          ? PaintingStyle.stroke
          : PaintingStyle.fill;

    _leftPro(canvas, size);
    _rightPro(canvas, size);
    if (leftText != null) {
      _drawLeftText(canvas);
    }
    if (rightText != null) {
      _drawRightText(canvas);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _leftPro(canvas, size) {
    Path _leftPath = Path();
    _leftPath.moveTo(_kProPaddingWidth + _strokeWidth * 0.5, Offset.zero.dy);
    _leftPath.lineTo(_kProPaddingWidth + _strokeWidth * 0.5, _height);
    if ((size.width * leftProgress +
            _height * 0.5 -
            _spaceWidth * 0.5 -
            _strokeWidth) <=
        _height) {
      _leftPath.lineTo(
          _height + _kProPaddingWidth + _strokeWidth * 0.5, _height);
      _leftTextWidth = 0.0;
    } else if ((size.width * leftProgress + _height * 0.5) >=
        size.width - _height) {
      _leftPath.lineTo(
          size.width - _spaceWidth - _strokeWidth * 2 - _kProPaddingWidth,
          _height);
      _leftPath.lineTo(
          size.width -
              _spaceWidth -
              _strokeWidth * 2 -
              _height -
              _kProPaddingWidth,
          Offset.zero.dy);
      _leftTextWidth = size.width -
          _spaceWidth -
          _strokeWidth * 2 -
          _height -
          _kProPaddingWidth * 2.5;
    } else {
      _leftPath.lineTo(
          size.width * leftProgress +
              _height * 0.5 -
              _spaceWidth * 0.5 -
              _strokeWidth,
          _height);
      _leftPath.lineTo(
          size.width * leftProgress -
              _height * 0.5 -
              _spaceWidth * 0.5 -
              _strokeWidth,
          Offset.zero.dy);
      _leftTextWidth =
          (size.width - _spaceWidth - 3 * _kProPaddingWidth) * leftProgress -
              _height * 0.5 -
              _strokeWidth;
    }
    _leftPath.lineTo(_kProPaddingWidth + _strokeWidth * 0.5, Offset.zero.dy);
    _leftPath.close();
    canvas.drawPath(_leftPath, _paint..color = leftColor ?? _kProLeftColor);
  }

  _rightPro(canvas, size) {
    Path _rightPath = Path();
    _rightPath.moveTo(
        size.width - _kProPaddingWidth - _strokeWidth * 0.5, Offset.zero.dy);
    _rightPath.lineTo(
        size.width - _kProPaddingWidth - _strokeWidth * 0.5, _height);

    if ((size.width * leftProgress +
            _height * 0.5 -
            _spaceWidth * 0.5 -
            _strokeWidth) <=
        _height) {
      _rightPath.lineTo(
          _height + _spaceWidth + _strokeWidth * 2 + _kProPaddingWidth,
          _height);
      _rightPath.lineTo(
          _spaceWidth + _strokeWidth * 2 + _kProPaddingWidth, Offset.zero.dy);
      _rightStartWidth =
          _height + _kProPaddingWidth + _strokeWidth + _spaceWidth;
      _rightTextWidth = size.width -
          _strokeWidth * 4 -
          _kProPaddingWidth * 2 -
          _height -
          _spaceWidth * 2;
    } else if ((size.width * leftProgress + _height * 0.5) >=
        size.width - _height) {
      _rightPath.lineTo(
          size.width - _height - _strokeWidth * 0.5 - _kProPaddingWidth,
          Offset.zero.dy);
      _rightTextWidth = 0.0;
    } else {
      _rightPath.lineTo(
          size.width * leftProgress +
              _height * 0.5 +
              _spaceWidth * 0.5 +
              _strokeWidth,
          _height);
      _rightPath.lineTo(
          size.width * leftProgress -
              _height * 0.5 +
              _spaceWidth * 0.5 +
              _strokeWidth,
          Offset.zero.dy);
      _rightStartWidth =
          (size.width - _spaceWidth - 2 * _kProPaddingWidth) * leftProgress +
              _spaceWidth +
              _height * 0.5 +
              _strokeWidth;
      _rightTextWidth =
          (size.width - _spaceWidth - _kProPaddingWidth) * (1 - leftProgress) -
              _kProPaddingWidth -
              _height * 0.5 -
              _strokeWidth * 1;
    }
    _rightPath.lineTo(
        size.width - _kProPaddingWidth - _strokeWidth * 0.5, Offset.zero.dy);
    _rightPath.close();
    canvas.drawPath(_rightPath, _paint..color = rightColor ?? _kProRightColor);
  }

  _drawLeftText(canvas) {
    if (_leftTextWidth > 0.0) {
      Color _leftColor;
      if (leftTextColor != null) {
        _leftColor = leftTextColor;
      } else if (isFill != null && this.isFill == true) {
        _leftColor = Colors.white;
      } else if (leftColor != null) {
        _leftColor = leftColor;
      } else {
        _leftColor = _kProLeftColor;
      }
      ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          maxLines: 1,
          ellipsis: '...',
          fontSize: 16))
        ..pushStyle(ui.TextStyle(color: _leftColor))
        ..addText(leftText);
      ParagraphConstraints pc = ParagraphConstraints(width: _leftTextWidth);
      Paragraph paragraph = _pb.build()..layout(pc);
      canvas.drawParagraph(
          paragraph,
          Offset(_kProPaddingWidth * 2 + _strokeWidth,
              _height * 0.5 - paragraph.height * 0.5));
    }
  }

  _drawRightText(canvas) {
    if (_rightTextWidth > 0.0) {
      Color _rightColor;
      if (rightTextColor != null) {
        _rightColor = rightTextColor;
      } else if (isFill != null && this.isFill == true) {
        _rightColor = Colors.white;
      } else if (rightColor != null) {
        _rightColor = rightColor;
      } else {
        _rightColor = _kProRightColor;
      }
      ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
          textAlign: TextAlign.right,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          maxLines: 1,
          ellipsis: '...',
          fontSize: 16))
        ..pushStyle(ui.TextStyle(color: _rightColor))
        ..addText(rightText)
        ..addPlaceholder(_kProPaddingWidth * 2 + _strokeWidth, Offset.zero.dy,
            PlaceholderAlignment.middle);
      ParagraphConstraints pc = ParagraphConstraints(width: _rightTextWidth);
      Paragraph paragraph = _pb.build()..layout(pc);

      canvas.drawParagraph(paragraph,
          Offset(_rightStartWidth, _height * 0.5 - paragraph.height * 0.5));
    }
  }
}
