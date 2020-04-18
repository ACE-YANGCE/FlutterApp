import 'package:flutter/material.dart';

class ACEWave extends StatefulWidget {
// 波浪整体高度(裁剪后)
  final double allHeight;

// 一个周期波浪宽度 List
  final List<double> waveWidthList;

// 波峰到中心点高度 List
  final List<double> waveHeightList;

// 水平偏移量 List
  final List<double> startOffsetXList;

// 波峰距顶点偏移量 List
  final List<double> startOffsetYList;

// 时间 List
  final List<Duration> durationList;

// 渐变色 List
  final List<List<Color>> waveColorList;

  ACEWave(this.waveWidthList, this.waveHeightList, this.allHeight,
      {this.durationList,
      this.startOffsetXList,
      this.startOffsetYList,
      this.waveColorList});

  @override
  State<StatefulWidget> createState() =>
      _ACEWaveState(waveWidthList, waveHeightList, allHeight,
          startOffsetXList: startOffsetXList,
          startOffsetYList: startOffsetYList,
          durationList: durationList,
          waveColorList: waveColorList);
}

class _ACEWaveState extends State<ACEWave> with TickerProviderStateMixin {
  List<AnimationController> _waveControllerList;
  List<Animation<double>> _waveAnimationList;
  List<CurvedAnimation> _curvedAnimationList;

  final double allHeight;
  final List<double> waveWidthList,
      waveHeightList,
      startOffsetXList,
      startOffsetYList;
  final List<Duration> durationList;
  final List<List<Color>> waveColorList;

  _ACEWaveState(this.waveWidthList, this.waveHeightList, this.allHeight,
      {this.durationList,
      this.startOffsetXList,
      this.startOffsetYList,
      this.waveColorList});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      for (int i = 0; i < waveWidthList.length; i++) _itemWave(i),
    ]);
  }

  _itemWave(i) {
    return Transform.translate(
        offset: Offset(waveWidthList[i] * _curvedAnimationList[i].value, 0.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
                painter: _ACEWavePainter(
                    waveWidthList[i], waveHeightList[i], allHeight,
                    startOffsetX: startOffsetXList[i],
                    startOffsetY: startOffsetYList[i],
                    waveColor: waveColorList[i]))));
  }

  _initAnimations() {
    _waveControllerList = List<AnimationController>(waveWidthList.length);
    _waveAnimationList = List<Animation<double>>(waveWidthList.length);
    _curvedAnimationList = List<CurvedAnimation>(waveWidthList.length);
    for (int i = 0; i < waveWidthList.length; i++) {
      _waveControllerList[i] = AnimationController(
          duration: (this.durationList != null && this.durationList[i] != null)
              ? this.durationList[i]
              : Duration(milliseconds: 3000),
          vsync: this);
      _curvedAnimationList[i] =
          CurvedAnimation(parent: _waveControllerList[i], curve: Curves.linear);
      _waveAnimationList[i] =
          Tween(begin: 0.0, end: 1.0).animate(_waveControllerList[i]);
      _waveAnimationList[i].addListener(() => setState(() {}));
      _waveControllerList[i].forward();
      _waveAnimationList[i].addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            _waveControllerList[i].repeat();
            break;
          case AnimationStatus.dismissed:
            _waveControllerList[i].forward();
            break;
          default:
            break;
        }
      });
    }
  }

  _disposeAnimations() {
    for (int i = 0; i < waveWidthList.length; i++) {
      _waveControllerList[i].dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }
}

class _ACEWavePainter extends CustomPainter {
  final double waveHeight, waveWidth, allHeight;
  double startOffsetX = 0.0, startOffsetY = 10.0;
  List<Color> waveColor;
  var _quaterWidth = 0.0;
  int _count = 1;
  var _shader, _plusWidth;

  _ACEWavePainter(this.waveWidth, this.waveHeight, this.allHeight,
      {this.startOffsetX, this.startOffsetY, this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    _quaterWidth = waveWidth * 0.25;
    _count = (waveWidth <= size.width)
        ? size.width ~/ waveWidth + 1
        : waveWidth ~/ size.width + 1;
    startOffsetX =
        ((waveWidth <= size.width) ? startOffsetX : startOffsetX * (-1)) %
            waveWidth;
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6
      ..style = PaintingStyle.fill;

    _shader = Offset(0.0, startOffsetY) &
        Size(size.width,
            allHeight <= waveHeight * 2 ? waveHeight * 2 : allHeight);
    paint.shader = LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: waveColor != null
                ? waveColor
                : [Colors.blue.withOpacity(0.2), Colors.white.withOpacity(0.4)])
        .createShader(_shader);

    _plusWidth = waveWidth * _count - size.width;
    canvas.save();
    canvas.clipPath(_clipPath(size, _plusWidth));
    canvas.drawPath(_wavePath(size, _plusWidth), paint);
    canvas.restore();
  }

  Path _clipPath(size, plusWidth) {
    Path _clipPath = Path();
    _clipPath.moveTo(-size.width - startOffsetX, Offset.zero.dy);
    _clipPath.lineTo(
        size.width - startOffsetX + _plusWidth * 2, Offset.zero.dy);
    _clipPath.lineTo(size.width - startOffsetX + _plusWidth * 2, allHeight);
    _clipPath.lineTo(-size.width - startOffsetX, allHeight);
    _clipPath.lineTo(-size.width - startOffsetX, Offset.zero.dy);
    return _clipPath;
  }

  Path _wavePath(size, plusWidth) {
    Path _path = Path();
    for (int i = 0; i < _count; i++) {
      _path.moveTo(waveWidth * i - size.width - startOffsetX, startOffsetY);
      _path.quadraticBezierTo(
          _quaterWidth + waveWidth * i - size.width - startOffsetX,
          startOffsetY - waveHeight,
          _quaterWidth * 2 + waveWidth * i - size.width - startOffsetX,
          startOffsetY);
      _path.moveTo(_quaterWidth * 2 + waveWidth * i - size.width - startOffsetX,
          startOffsetY);
      _path.quadraticBezierTo(
          _quaterWidth * 3 + waveWidth * i - size.width - startOffsetX,
          startOffsetY + waveHeight,
          _quaterWidth * 4 + waveWidth * i - size.width - startOffsetX,
          startOffsetY);
      _path.moveTo(_quaterWidth * 4 + waveWidth * i - size.width - startOffsetX,
          startOffsetY);
    }
    _path.lineTo(
        _quaterWidth * 4 + waveWidth * (_count - 1) - size.width - startOffsetX,
        allHeight <= waveHeight * 2 ? waveHeight * 2 : allHeight);
    _path.lineTo(-size.width - startOffsetX,
        allHeight <= waveHeight * 2 ? waveHeight * 2 : allHeight);
    _path.lineTo(-size.width - startOffsetX, startOffsetY);

    for (int i = 0; i < _count; i++) {
      _path.moveTo(waveWidth * i - startOffsetX + plusWidth, startOffsetY);
      _path.quadraticBezierTo(
          _quaterWidth + waveWidth * i - startOffsetX + plusWidth,
          startOffsetY - waveHeight,
          _quaterWidth * 2 + waveWidth * i - startOffsetX + plusWidth,
          startOffsetY);
      _path.moveTo(_quaterWidth * 2 + waveWidth * i - startOffsetX + plusWidth,
          startOffsetY);
      _path.quadraticBezierTo(
          _quaterWidth * 3 + waveWidth * i - startOffsetX + plusWidth,
          startOffsetY + waveHeight,
          _quaterWidth * 4 + waveWidth * i - startOffsetX + plusWidth,
          startOffsetY);
      _path.moveTo(_quaterWidth * 4 + waveWidth * i - startOffsetX + plusWidth,
          startOffsetY);
    }
    _path.lineTo(
        _quaterWidth * 4 + waveWidth * (_count - 1) - startOffsetX + plusWidth,
        allHeight <= waveHeight * 2 ? waveHeight * 2 : allHeight);
    _path.lineTo(-startOffsetX + plusWidth,
        allHeight <= waveHeight * 2 ? waveHeight * 2 : allHeight);
    _path.lineTo(-startOffsetX + plusWidth, startOffsetY);

    for (int i = 0; i < _count; i++) {
      _path.moveTo(waveWidth * i + size.width - startOffsetX + plusWidth * 2,
          startOffsetY);
      _path.quadraticBezierTo(
          _quaterWidth +
              waveWidth * i +
              size.width -
              startOffsetX +
              plusWidth * 2,
          startOffsetY - waveHeight,
          _quaterWidth * 2 +
              waveWidth * i +
              size.width -
              startOffsetX +
              plusWidth * 2,
          startOffsetY);
      _path.moveTo(
          _quaterWidth * 2 +
              waveWidth * i +
              size.width -
              startOffsetX +
              plusWidth * 2,
          startOffsetY);
      _path.quadraticBezierTo(
          _quaterWidth * 3 +
              waveWidth * i +
              size.width -
              startOffsetX +
              plusWidth * 2,
          startOffsetY + waveHeight,
          _quaterWidth * 4 +
              waveWidth * i +
              size.width -
              startOffsetX +
              plusWidth * 2,
          startOffsetY);
      _path.moveTo(
          _quaterWidth * 4 +
              waveWidth * i +
              size.width -
              startOffsetX +
              plusWidth * 2,
          startOffsetY);
    }
    _path.lineTo(
        _quaterWidth * 4 +
            waveWidth * (_count - 1) +
            size.width -
            startOffsetX +
            plusWidth * 2,
        allHeight <= waveHeight * 2 ? waveHeight * 2 : allHeight);
    _path.lineTo(size.width - startOffsetX + plusWidth * 2,
        allHeight <= waveHeight * 2 ? waveHeight * 2 : allHeight);
    _path.lineTo(size.width - startOffsetX + plusWidth * 2, startOffsetY);
    return _path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
