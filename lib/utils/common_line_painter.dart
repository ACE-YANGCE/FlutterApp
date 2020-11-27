import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonLinePainter extends CustomPainter {
  BuildContext context;
  var betweenWidth;

  CommonLinePainter(this.context, this.betweenWidth);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    for (int i = 0; i < size.height / betweenWidth + 1; i++) {
      path.moveTo(0, betweenWidth * i);
      path.lineTo(size.width, betweenWidth * i);
    }
    for (int i = 0; i < size.width / betweenWidth + 1; i++) {
      path.moveTo(betweenWidth * i, 0);
      path.lineTo(betweenWidth * i, size.height);
    }
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
