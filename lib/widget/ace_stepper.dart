import 'package:flutter/material.dart';
import 'dart:math';

class ACEStepper extends StatefulWidget {
  final List<ACEStep> steps;
  final ScrollPhysics physics;
  final ACEStepperType type;
  final int currentStep;
  final ValueChanged<int> onStepTapped;
  final VoidCallback onStepContinue, onStepCancel;
  final bool isContinue, isCancel;
  final double headerHeight;
  final ControlsWidgetBuilder controlsBuilder;
  final ACEStepThemeData themeData;
  final bool isAllContent;

  const ACEStepper(
      {Key key,
      @required this.steps,
      this.physics,
      this.type = ACEStepperType.vertical,
      this.currentStep = 0,
      this.onStepTapped,
      this.onStepContinue,
      this.onStepCancel,
      this.isContinue = true,
      this.isCancel = true,
      this.headerHeight,
      this.controlsBuilder,
      this.themeData,
      this.isAllContent = false});

  @override
  State<StatefulWidget> createState() => _ACEStepperState();
}

class CircleData {
  final String circleText, circleAssUrl, circleNetUrl;
  final IconData circleIcon;

  CircleData(
      {this.circleText, this.circleAssUrl, this.circleNetUrl, this.circleIcon});
}

class ACEStepThemeData {
  final Color circleColor,
      circleActiveColor,
      contentColor,
      contentActiveColor,
      lineColor;
  final double circleDiameter;

  ACEStepThemeData(
      {this.circleColor = _kCircleColor,
      this.lineColor = _kLineColor,
      this.circleActiveColor = _kCircleActiveColor,
      this.contentColor = _kContentColor,
      this.contentActiveColor = _kContentActiveColor,
      this.circleDiameter = _kCircleDiameter});
}

class _ACEStepperState extends State<ACEStepper> with TickerProviderStateMixin {
  List<GlobalKey> _keys;
  final Map<int, LineType> _oldLineStates = <int, LineType>{};
  final Map<int, IconType> _oldIconStates = <int, IconType>{};

  @override
  void initState() {
    super.initState();
    _keys =
        List<GlobalKey>.generate(widget.steps.length, (int i) => GlobalKey());

    for (int i = 0; i < widget.steps.length; i += 1) {
      _oldLineStates[i] = widget.steps[i].lineType;
      _oldIconStates[i] = widget.steps[i].iconType;
    }
  }

  @override
  void didUpdateWidget(ACEStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1) {
      _oldLineStates[i] = oldWidget.steps[i].lineType;
      _oldIconStates[i] = oldWidget.steps[i].iconType;
    }
  }

  bool _isFirst(int index) => index == 0;

  bool _isLast(int index) => widget.steps.length - 1 == index;

  bool _isCurrent(int index) => widget.currentStep == index;

  @override
  Widget build(BuildContext context) => (widget.type == ACEStepperType.vertical)
      ? _buildVertical()
      : _buildHorizontal();

  Widget _buildLine(int index, bool state) {
    return Opacity(
        opacity: state ? 0.0 : 1.0,
        child: StepperLine(
            color: widget.themeData == null
                ? _kLineColor
                : widget.themeData.lineColor ?? _kLineColor,
            lineType: widget.steps[index].lineType,
            type: widget.type));
  }

  Widget _buildIcon(IconType type, CircleData circleData, int index) {
    Color contentActiveColor = widget.themeData == null
        ? _kContentActiveColor
        : widget.themeData.contentActiveColor ?? _kContentActiveColor;
    Color contentColor = widget.themeData == null
        ? _kContentColor
        : widget.themeData.contentColor ?? _kContentColor;
    Color _color =
        widget.steps[index].isActive ? contentActiveColor : contentColor;
    switch (type) {
      case IconType.text:
        return Text(circleData.circleText ?? (index + 1).toString(),
            style: TextStyle(color: _color));
        break;
      case IconType.icon:
        return circleData.circleIcon != null
            ? Icon(circleData.circleIcon, size: _kCircleIconSize, color: _color)
            : Text(circleData.circleText ?? (index + 1).toString(),
                style: TextStyle(color: _color));
        break;
      case IconType.ass_url:
        return circleData.circleAssUrl != null
            ? Padding(
                padding: EdgeInsets.all(_kCirclePadding),
                child: Image.asset(circleData.circleAssUrl, color: _color))
            : Text(circleData.circleText ?? (index + 1).toString(),
                style: TextStyle(color: _color));
        break;
      case IconType.net_url:
        return circleData.circleNetUrl != null
            ? Padding(
                padding: EdgeInsets.all(_kCirclePadding),
                child: Image.network(circleData.circleNetUrl))
            : Text(circleData.circleText ?? (index + 1).toString(),
                style: TextStyle(color: _color));
        break;
      default:
        return Text((index + 1).toString(), style: TextStyle(color: _color));
        break;
    }
  }

  Widget _buildCircle(
      IconType type, double size, CircleData circleData, int index) {
    Color circleActiveColor = widget.themeData == null
        ? _kCircleActiveColor
        : widget.themeData.circleActiveColor ?? _kCircleActiveColor;
    Color circleColor = widget.themeData == null
        ? _kCircleColor
        : widget.themeData.circleColor ?? _kCircleColor;
    return Stack(children: <Widget>[
      Container(
          child: CustomPaint(
              painter: _CirclePainter(
                  color: widget.steps[index].isActive
                      ? circleActiveColor
                      : circleColor,
                  size: size))),
      Container(
          width: size,
          height: size,
          child: Center(child: _buildIcon(type, circleData, index)))
    ]);
  }

  Widget _buildHeader(int index) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.steps[index].title,
          widget.steps[index].subtitle ?? SizedBox.shrink()
        ]);
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
        child: Row(children: <Widget>[
      Container(
          width: _kTopTipsWidth,
          padding: EdgeInsets.symmetric(horizontal: _kCircleMargin),
          child: Center(child: widget.steps[index].toptips)),
      Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        _buildLine(index, _isFirst(index)),
        SizedBox.fromSize(size: Size(_kCircleMargin, _kCircleMargin)),
        _buildCircle(
            widget.steps[index].iconType,
            widget.themeData == null
                ? _kCircleDiameter
                : widget.themeData.circleDiameter ?? _kCircleDiameter,
            widget.steps[index].circleData,
            index),
        SizedBox.fromSize(size: Size(_kCircleMargin, _kCircleMargin)),
        _buildLine(index, _isLast(index))
      ]),
      Container(
          margin: EdgeInsets.symmetric(horizontal: _kCircleMargin),
          child: _buildHeader(index))
    ]));
  }

  Widget _buildHorizontalHeader(int index) {
    return Container(
        child: Column(children: <Widget>[
      Container(
          height: _kTopTipsHeight,
          padding: EdgeInsets.symmetric(horizontal: _kCircleMargin),
          child: Center(child: widget.steps[index].toptips)),
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _buildLine(index, _isFirst(index)),
        SizedBox.fromSize(size: Size(_kCircleMargin, _kCircleMargin)),
        _buildCircle(
            widget.steps[index].iconType,
            widget.themeData == null
                ? _kCircleDiameter
                : widget.themeData.circleDiameter ?? _kCircleDiameter,
            widget.steps[index].circleData,
            index),
        SizedBox.fromSize(size: Size(_kCircleMargin, _kCircleMargin)),
        _buildLine(index, _isLast(index))
      ]),
      Container(
          margin: EdgeInsets.symmetric(vertical: _kCircleMargin),
          child: _buildHeader(index))
    ]));
  }

  Widget _buildVerticalControls() {
    return (widget.controlsBuilder != null)
        ? widget.controlsBuilder(context,
            onStepContinue: widget.onStepContinue,
            onStepCancel: widget.onStepCancel)
        : Container(
            child: Row(children: <Widget>[
            widget.isContinue
                ? FlatButton(
                    onPressed: widget.onStepContinue, child: Text('继续'))
                : SizedBox.shrink(),
            widget.isCancel
                ? FlatButton(onPressed: widget.onStepCancel, child: Text('取消'))
                : SizedBox.shrink()
          ]));
  }

  Widget _buildVerticalBody(int index) {
    double circleDiameter = widget.themeData == null
        ? _kCircleDiameter
        : widget.themeData.circleDiameter ?? _kCircleDiameter;
    return Stack(children: <Widget>[
      PositionedDirectional(
          start: _kTopTipsWidth + (circleDiameter - _kLineWidth) * 0.5,
          top: Size.zero.width,
          bottom: Size.zero.width - 2,
          child: _isLast(index)
              ? SizedBox.shrink()
              : AspectRatio(
                  aspectRatio: 1,
                  child: SizedBox.expand(child: _buildLine(index, false)))),
      widget.isAllContent
          ? Container(
              margin: EdgeInsets.only(
                  left: _kTopTipsWidth + _kCircleMargin * 2 + circleDiameter),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.steps[index].content ?? SizedBox.shrink(),
                    _buildVerticalControls()
                  ]))
          : AnimatedCrossFade(
              firstChild: SizedBox.shrink(),
              secondChild: Container(
                  margin: EdgeInsetsDirectional.only(
                      start:
                          _kTopTipsWidth + _kCircleMargin * 2 + circleDiameter),
                  child: Column(children: <Widget>[
                    widget.steps[index].content ?? SizedBox.shrink(),
                    _buildVerticalControls()
                  ])),
              crossFadeState: _isCurrent(index)
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 1))
    ]);
  }

  Widget _buildVertical() {
    return ListView(
        shrinkWrap: true,
        physics: widget.physics,
        children: <Widget>[
          for (int i = 0; i < widget.steps.length; i += 1)
            Column(key: _keys[i], children: <Widget>[
              InkWell(
                  child: _buildVerticalHeader(i),
                  onTap: () => (widget.onStepTapped != null)
                      ? widget.onStepTapped(i)
                      : null),
              _buildVerticalBody(i)
            ])
        ]);
  }

  Widget _buildHorizontal() {
    return Column(children: <Widget>[
      Container(
          height: widget.headerHeight == null || widget.headerHeight <= 0.0
              ? _kHeaderHeight
              : widget.headerHeight,
          child: ListView(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                for (int i = 0; i < widget.steps.length; i += 1)
                  Column(key: _keys[i], children: <Widget>[
                    InkWell(
                        child: _buildHorizontalHeader(i),
                        onTap: () => (widget.onStepTapped != null)
                            ? widget.onStepTapped(i)
                            : null)
                  ])
              ])),
      Expanded(
          child: ListView(children: <Widget>[
        Container(
            child:
                widget.steps[widget.currentStep].content ?? SizedBox.shrink()),
        _buildVerticalControls()
      ]))
    ]);
  }
}

class ACEStep {
  const ACEStep(
      {@required this.title,
      @required this.circleData,
      this.content,
      this.subtitle,
      this.toptips,
      this.lineType = LineType.normal,
      this.iconType = IconType.text,
      this.isActive = false});

  final Widget title, subtitle, toptips, content;
  final LineType lineType;
  final IconType iconType;
  final bool isActive;
  final CircleData circleData;
}

class StepperLine extends StatelessWidget {
  final Color color;
  final LineType lineType;
  final ACEStepperType type;

  StepperLine(
      {@required this.color,
      this.type = ACEStepperType.horizontal,
      this.lineType = LineType.normal});

  @override
  Widget build(BuildContext context) {
    double _width =
        (type == ACEStepperType.horizontal) ? _kLineHeight : _kLineWidth;
    double _height =
        (type == ACEStepperType.horizontal) ? _kLineWidth : _kLineHeight;
    double _diameter = (type == ACEStepperType.horizontal) ? _height : _width;
    return lineType == LineType.normal
        ? Container(width: _width, height: _height, color: color)
        : Container(
            width: _width,
            height: _height,
            child: CustomPaint(
                painter: _LinePainter(
                    color: color, radius: _diameter * 0.5, type: type)));
  }
}

class _LinePainter extends CustomPainter {
  final Color color;
  final double radius;
  final ACEStepperType type;

  _LinePainter({this.color, this.radius, this.type});

  @override
  bool hitTest(Offset point) => true;

  @override
  bool shouldRepaint(_LinePainter oldPainter) => oldPainter.color != color;

  @override
  void paint(Canvas canvas, Size size) {
    double _circleLength = (type == ACEStepperType.horizontal)
        ? size.width.toDouble()
        : size.height.toDouble();
    double _circleSize = _circleLength / radius / 4 > 2
        ? _circleLength / radius / 4 - 1
        : _circleLength / radius / 4;
    Path _path = Path();
    for (int i = 0; i < _circleSize; i++) {
      _path.addArc(
          Rect.fromCircle(
              center: Offset(
                  type == ACEStepperType.horizontal
                      ? radius + 4 * radius * i
                      : radius,
                  type == ACEStepperType.horizontal
                      ? radius
                      : radius + 4 * radius * i),
              radius: radius),
          0.0,
          2 * pi);
    }
    canvas.drawPath(
        _path,
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill);
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;
  final double size;

  _CirclePainter({this.color, this.size});

  @override
  bool hitTest(Offset point) => true;

  @override
  bool shouldRepaint(_CirclePainter oldPainter) => oldPainter.color != color;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = this.size * 0.5;

    canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        0.0,
        2 * pi,
        false,
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke);
  }
}

enum LineType { normal, circle }
enum IconType { text, icon, ass_url, net_url }
enum ACEStepperType { vertical, horizontal }

// toptips width
const double _kTopTipsWidth = 60.0;
// toptips height
const double _kTopTipsHeight = 40.0;
// circle diameter
const double _kCircleDiameter = 26.0;
// circle margin
const double _kCircleMargin = 6.0;
// circle padding
const double _kCirclePadding = 4.0;
// circle icon size
const double _kCircleIconSize = 14.0;
// circle active color
const Color _kCircleActiveColor = Colors.redAccent;
// circle color
const Color _kCircleColor = Colors.grey;
// circle content active color
const Color _kContentActiveColor = Colors.redAccent;
// circle content color
const Color _kContentColor = Colors.grey;
// line color
const Color _kLineColor = Colors.redAccent;
// line width
const double _kLineWidth = 1.0;
// line height
const double _kLineHeight = 25.0;
// horizontal header height
const double _kHeaderHeight = 120.0;
