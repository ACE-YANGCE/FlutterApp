import 'package:flutter/material.dart';

class ACEWaterButton extends StatefulWidget {
  final double innerSize;
  final double outSize;
  final Widget innerIcon;
  final Color color;
  final Duration duration;

  const ACEWaterButton(this.color,
      {this.innerSize = 48.0, this.outSize, this.innerIcon, this.duration});

  @override
  _ACEWaterButtonState createState() => _ACEWaterButtonState();
}

class _ACEWaterButtonState extends State<ACEWaterButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? Duration(milliseconds: 2000))
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(children: [
            CustomPaint(
                size: Size(widget.outSize ?? widget.innerSize * 2,
                    widget.outSize ?? widget.innerSize * 2),
                painter: ACEWaterPainter(_controller.value, widget.color,
                    widget.innerSize, widget.outSize)),
            Container(
                color: Colors.grey.withOpacity(0.1),
                width: widget.outSize ?? widget.innerSize * 2,
                height: widget.outSize ?? widget.innerSize * 2,
                child: widget.innerIcon == null
                    ? Container()
                    : Center(
                        child: ClipOval(
                            child: Container(
                                width: widget.innerSize,
                                height: widget.innerSize,
                                color: widget.color,
                                child: widget.innerIcon))))
          ]);
        });
  }
}

class ACEWaterPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double innerSize;
  final double outSize;

  Paint _paint = Paint()..style = PaintingStyle.fill;

  ACEWaterPainter(this.progress, this.color, this.innerSize, this.outSize);

  @override
  void paint(Canvas canvas, Size size) {
    _paint..color = color.withOpacity(1.0 - progress);

    // double _radius = radius * progress;
    // double _radius = radius * progress + innerSize * 0.5;
    double _radius =
        ((outSize ?? innerSize * 2) * 0.5 - innerSize * 0.5) * progress +
            innerSize * 0.5;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), _radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
