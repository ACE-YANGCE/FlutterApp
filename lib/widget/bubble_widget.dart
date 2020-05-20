import 'dart:math';

import 'package:flutter/material.dart';

enum BubbleArrowDirection { top, bottom, right, left }

class BubbleWidget extends StatelessWidget {
  // 尖角位置
  final position;

  // 尖角高度
  var arrHeight;

  // 尖角角度
  var arrAngle;

  // 圆角半径
  var radius;

  // 宽度
  final width;

  // 高度
  final height;

  // 边距
  double length;

  // 颜色
  Color color;

  // 边框颜色
  Color borderColor;

  // 边框宽度
  final strokeWidth;

  // 填充样式
  final style;

  // 子 Widget
  final child;

  // 子 Widget 与起泡间距
  var innerPadding;

  BubbleWidget(
    this.width,
    this.height,
    this.color,
    this.position, {
    Key key,
    this.length = -1.0,
    this.arrHeight = 12.0,
    this.arrAngle = 60.0,
    this.radius = 10.0,
    this.strokeWidth = 4.0,
    this.style = PaintingStyle.fill,
    this.borderColor,
    this.child,
    this.innerPadding = 6.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (style == PaintingStyle.stroke && borderColor == null) {
      borderColor = color;
    }
    if (arrAngle < 0.0 || arrAngle >= 180.0) {
      arrAngle = 60.0;
    }
    if (arrHeight < 0.0) {
      arrHeight = 0.0;
    }
    if (radius < 0.0 || radius > width * 0.5 || radius > height * 0.5) {
      radius = 0.0;
    }
    if (position == BubbleArrowDirection.top ||
        position == BubbleArrowDirection.bottom) {
      if (length < 0.0 || length >= width - 2 * radius) {
        length = width * 0.5 - arrHeight * tan(_angle(arrAngle * 0.5)) - radius;
      }
    } else {
      if (length < 0.0 || length >= height - 2 * radius) {
        length =
            height * 0.5 - arrHeight * tan(_angle(arrAngle * 0.5)) - radius;
      }
    }
    if (innerPadding < 0.0 ||
        innerPadding >= width * 0.5 ||
        innerPadding >= height * 0.5) {
      innerPadding = 2.0;
    }
    Widget bubbleWidget;
    if (style == PaintingStyle.fill) {
      bubbleWidget = Container(
          width: width,
          height: height,
          child: Stack(children: <Widget>[
            CustomPaint(
                painter: BubbleCanvas(context, width, height, color, position,
                    arrHeight, arrAngle, radius, strokeWidth, style, length)),
            _paddingWidget()
          ]));
    } else {
      bubbleWidget = Container(
          width: width,
          height: height,
          child: Stack(children: <Widget>[
            CustomPaint(
                painter: BubbleCanvas(
                    context,
                    width,
                    height,
                    color,
                    position,
                    arrHeight,
                    arrAngle,
                    radius,
                    strokeWidth,
                    PaintingStyle.fill,
                    length)),
            CustomPaint(
                painter: BubbleCanvas(
                    context,
                    width,
                    height,
                    borderColor,
                    position,
                    arrHeight,
                    arrAngle,
                    radius,
                    strokeWidth,
                    style,
                    length)),
            _paddingWidget()
          ]));
    }
    return bubbleWidget;
  }

  Widget _paddingWidget() {
    return Padding(
        padding: EdgeInsets.only(
            top: (position == BubbleArrowDirection.top)
                ? arrHeight + innerPadding
                : innerPadding,
            right: (position == BubbleArrowDirection.right)
                ? arrHeight + innerPadding
                : innerPadding,
            bottom: (position == BubbleArrowDirection.bottom)
                ? arrHeight + innerPadding
                : innerPadding,
            left: (position == BubbleArrowDirection.left)
                ? arrHeight + innerPadding
                : innerPadding),
        child: Center(child: this.child));
  }
}

class BubbleCanvas extends CustomPainter {
  BuildContext context;
  final position;
  final arrHeight;
  final arrAngle;
  final radius;
  final width;
  final height;
  final length;
  final color;
  final strokeWidth;
  final style;

  BubbleCanvas(
      this.context,
      this.width,
      this.height,
      this.color,
      this.position,
      this.arrHeight,
      this.arrAngle,
      this.radius,
      this.strokeWidth,
      this.style,
      this.length);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.arcTo(
        Rect.fromCircle(
            center: Offset(
                (position == BubbleArrowDirection.left)
                    ? radius + arrHeight
                    : radius,
                (position == BubbleArrowDirection.top)
                    ? radius + arrHeight
                    : radius),
            radius: radius),
        pi,
        pi * 0.5,
        false);
    if (position == BubbleArrowDirection.top) {
      path.lineTo(length + radius, arrHeight);
      path.lineTo(
          length + radius + arrHeight * tan(_angle(arrAngle * 0.5)), 0.0);
      path.lineTo(length + radius + arrHeight * tan(_angle(arrAngle * 0.5)) * 2,
          arrHeight);
    }
    path.lineTo(
        (position == BubbleArrowDirection.right)
            ? width - radius - arrHeight
            : width - radius,
        (position == BubbleArrowDirection.top) ? arrHeight : 0.0);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(
                (position == BubbleArrowDirection.right)
                    ? width - radius - arrHeight
                    : width - radius,
                (position == BubbleArrowDirection.top)
                    ? radius + arrHeight
                    : radius),
            radius: radius),
        -pi * 0.5,
        pi * 0.5,
        false);
    if (position == BubbleArrowDirection.right) {
      path.lineTo(width - arrHeight, length + radius);
      path.lineTo(
          width, length + radius + arrHeight * tan(_angle(arrAngle * 0.5)));
      path.lineTo(width - arrHeight,
          length + radius + arrHeight * tan(_angle(arrAngle * 0.5)) * 2);
    }
    path.lineTo(
        (position == BubbleArrowDirection.right) ? width - arrHeight : width,
        (position == BubbleArrowDirection.bottom)
            ? height - radius - arrHeight
            : height - radius);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(
                (position == BubbleArrowDirection.right)
                    ? width - radius - arrHeight
                    : width - radius,
                (position == BubbleArrowDirection.bottom)
                    ? height - radius - arrHeight
                    : height - radius),
            radius: radius),
        pi * 0,
        pi * 0.5,
        false);
    if (position == BubbleArrowDirection.bottom) {
      path.lineTo(width - radius - length, height - arrHeight);
      path.lineTo(
          width - radius - length - arrHeight * tan(_angle(arrAngle * 0.5)),
          height);
      path.lineTo(
          width - radius - length - arrHeight * tan(_angle(arrAngle * 0.5)) * 2,
          height - arrHeight);
    }
    path.lineTo(
        (position == BubbleArrowDirection.left) ? radius + arrHeight : radius,
        (position == BubbleArrowDirection.bottom)
            ? height - arrHeight
            : height);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(
                (position == BubbleArrowDirection.left)
                    ? radius + arrHeight
                    : radius,
                (position == BubbleArrowDirection.bottom)
                    ? height - radius - arrHeight
                    : height - radius),
            radius: radius),
        pi * 0.5,
        pi * 0.5,
        false);
    if (position == BubbleArrowDirection.left) {
      path.lineTo(arrHeight, height - radius - length);
      path.lineTo(0.0,
          height - radius - length - arrHeight * tan(_angle(arrAngle * 0.5)));
      path.lineTo(
          arrHeight,
          height -
              radius -
              length -
              arrHeight * tan(_angle(arrAngle * 0.5)) * 2);
    }
    path.lineTo((position == BubbleArrowDirection.left) ? arrHeight : 0.0,
        (position == BubbleArrowDirection.top) ? radius + arrHeight : radius);
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = style
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

double _angle(angle) {
  return angle * pi / 180;
}
