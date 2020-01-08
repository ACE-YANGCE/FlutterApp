import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ACECheckbox extends StatefulWidget {
  const ACECheckbox(
      {Key key,
      @required this.value,
      this.tristate = false,
      @required this.onChanged,
      this.activeColor,
      this.checkColor,
      this.unCheckColor,
      this.materialTapTargetSize,
      this.type = ACECheckBoxType.normal,
      this.width = 18.0})
      : assert(tristate != null),
        assert(tristate || value != null),
        super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final Color unCheckColor;
  final bool tristate;
  final MaterialTapTargetSize materialTapTargetSize;
  final ACECheckBoxType type;
  final double width;

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<ACECheckbox> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);
    Size size;
    switch (widget.materialTapTargetSize ?? themeData.materialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        size = const Size(
            2 * kRadialReactionRadius + 8.0, 2 * kRadialReactionRadius + 8.0);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        size = const Size(2 * kRadialReactionRadius, 2 * kRadialReactionRadius);
        break;
    }
    final BoxConstraints additionalConstraints = BoxConstraints.tight(size);
    return _CheckboxRenderObjectWidget(
        value: widget.value,
        tristate: widget.tristate,
        activeColor: widget.activeColor ?? themeData.toggleableActiveColor,
        checkColor: widget.checkColor ?? const Color(0xFFFFFFFF),
        inactiveColor: widget.onChanged != null
            ? widget.unCheckColor ?? themeData.unselectedWidgetColor
            : themeData.disabledColor,
        type: widget.type ?? ACECheckBoxType.normal,
        width: widget.width ?? 18.0,
        onChanged: widget.onChanged,
        additionalConstraints: additionalConstraints,
        vsync: this);
  }
}

class _CheckboxRenderObjectWidget extends LeafRenderObjectWidget {
  const _CheckboxRenderObjectWidget({
    Key key,
    @required this.value,
    @required this.tristate,
    @required this.activeColor,
    @required this.checkColor,
    @required this.inactiveColor,
    @required this.onChanged,
    @required this.vsync,
    @required this.type,
    @required this.width,
    @required this.additionalConstraints,
  })  : assert(tristate != null),
        assert(tristate || value != null),
        assert(activeColor != null),
        assert(inactiveColor != null),
        assert(vsync != null),
        super(key: key);

  final bool value;
  final bool tristate;
  final Color activeColor;
  final Color checkColor;
  final Color inactiveColor;
  final ValueChanged<bool> onChanged;
  final TickerProvider vsync;
  final BoxConstraints additionalConstraints;
  final ACECheckBoxType type;
  final double width;

  @override
  _RenderCheckbox createRenderObject(BuildContext context) => _RenderCheckbox(
      value: value,
      tristate: tristate,
      activeColor: activeColor,
      checkColor: checkColor,
      inactiveColor: inactiveColor,
      onChanged: onChanged,
      type: type,
      width: width,
      vsync: vsync,
      additionalConstraints: additionalConstraints);

  @override
  void updateRenderObject(BuildContext context, _RenderCheckbox renderObject) {
    renderObject
      ..value = value
      ..tristate = tristate
      ..activeColor = activeColor
      ..checkColor = checkColor
      ..inactiveColor = inactiveColor
      ..onChanged = onChanged
      ..type = type
      ..width = width
      ..additionalConstraints = additionalConstraints
      ..vsync = vsync;
  }
}

// 圆角矩形圆角
const Radius _kEdgeRadius = Radius.circular(1.0);
// 边框宽度
const double _kStrokeWidth = 2.0;

class _RenderCheckbox extends RenderToggleable {
  _RenderCheckbox({
    bool value,
    bool tristate,
    Color activeColor,
    this.checkColor,
    Color inactiveColor,
    this.type,
    this.width,
    BoxConstraints additionalConstraints,
    ValueChanged<bool> onChanged,
    @required TickerProvider vsync,
  })  : _oldValue = value,
        super(
            value: value,
            tristate: tristate,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            onChanged: onChanged,
            additionalConstraints: additionalConstraints,
            vsync: vsync);

  bool _oldValue;
  Color checkColor;
  ACECheckBoxType type;
  double width;

  @override
  set value(bool newValue) {
    if (newValue == value) return;
    _oldValue = value;
    super.value = newValue;
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isChecked = value == true;
  }

  // The square outer bounds of the checkbox at t, with the specified origin.
  // At t == 0.0, the outer rect's size is _kEdgeSize (Checkbox.width)
  // At t == 0.5, .. is _kEdgeSize - _kStrokeWidth
  // At t == 1.0, .. is _kEdgeSize
  RRect _outerRectAt(Offset origin, double t) {
    final double inset = 1.0 - (t - 0.5).abs() * 2.0;
    final double size = width - inset * _kStrokeWidth;
    final Rect rect =
        Rect.fromLTWH(origin.dx + inset, origin.dy + inset, size, size);
    return RRect.fromRectAndRadius(rect, _kEdgeRadius);
  }

  // The checkbox's border color if value == false, or its fill color when
  // value == true or null.
  Color _colorAt(double t) {
    // As t goes from 0.0 to 0.25, animate from the inactiveColor to activeColor.
    return onChanged == null
        ? inactiveColor
        : (t >= 0.25
            ? activeColor
            : Color.lerp(inactiveColor, activeColor, t * 4.0));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    paintRadialReaction(canvas, offset, size.center(Offset.zero));

    final Paint strokePaint = _createStrokePaint(checkColor);
    final Offset origin = offset + (size / 2.0 - Size.square(width) / 2.0);
    final AnimationStatus status = position.status;
    final double tNormalized =
        status == AnimationStatus.forward || status == AnimationStatus.completed
            ? position.value
            : 1.0 - position.value;
    // Four cases: false to null, false to true, null to false, true to false
    if (_oldValue == false || value == false) {
      final double t = value == false ? 1.0 - tNormalized : tNormalized;
      final RRect outer = _outerRectAt(origin, t);
      final Paint paint = Paint()..color = _colorAt(t);
      if (t <= 0.5) {
        _drawBorder(canvas, outer, t, origin, type, paint);
      } else {
        _drawInner(canvas, outer, origin, type, paint);
        final double tShrink = (t - 0.5) * 2.0;
        if (_oldValue == null || value == null)
          _drawDash(canvas, origin, tShrink, width, strokePaint);
        else
          _drawCheck(canvas, origin, tShrink, width, strokePaint);
      }
    } else {
      // Two cases: null to true, true to null
      final RRect outer = _outerRectAt(origin, 1.0);
      final Paint paint = Paint()..color = _colorAt(1.0);
      _drawInner(canvas, outer, origin, type, paint);
      if (tNormalized <= 0.5) {
        final double tShrink = 1.0 - tNormalized * 2.0;
        if (_oldValue == true)
          _drawCheck(canvas, origin, tShrink, width, strokePaint);
        else
          _drawDash(canvas, origin, tShrink, width, strokePaint);
      } else {
        final double tExpand = (tNormalized - 0.5) * 2.0;
        if (value == true)
          _drawCheck(canvas, origin, tExpand, width, strokePaint);
        else
          _drawDash(canvas, origin, tExpand, width, strokePaint);
      }
    }
  }
}

Paint _createStrokePaint(checkColor) {
  return Paint()
    ..color = checkColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = _kStrokeWidth;
}

_drawBorder(canvas, outer, t, offset, type, paint) {
  assert(t >= 0.0 && t <= 0.5);
  final double size = outer.width;
  if ((type ?? ACECheckBoxType.normal) == ACECheckBoxType.normal) {
    canvas.drawDRRect(
        outer,
        outer.deflate(math.min(size / 2.0, _kStrokeWidth + size * t)),
        paint
          ..strokeWidth = _kStrokeWidth / 2.0
          ..style = PaintingStyle.fill);
  } else {
    canvas.drawCircle(
        Offset(offset.dx + size / 2.0, offset.dy + size / 2.0),
        size / 2.0,
        paint
          ..strokeWidth = _kStrokeWidth
          ..style = PaintingStyle.stroke);
  }
}

_drawInner(canvas, outer, offset, type, paint) {
  if ((type ?? ACECheckBoxType.normal) == ACECheckBoxType.normal) {
    canvas.drawRRect(outer, paint);
  } else {
    canvas.drawCircle(
        Offset(offset.dx + outer.width / 2.0, offset.dy + outer.width / 2.0),
        outer.width / 2.0,
        paint);
  }
}

_drawCheck(Canvas canvas, Offset origin, double t, double width, Paint paint) {
  assert(t >= 0.0 && t <= 1.0);
  // As t goes from 0.0 to 1.0, animate the two check mark strokes from the
  // short side to the long side.
  final Path path = Path();
  Offset start = Offset(width * 0.15, width * 0.45);
  Offset mid = Offset(width * 0.4, width * 0.7);
  Offset end = Offset(width * 0.85, width * 0.25);
  if (t < 0.5) {
    final double strokeT = t * 2.0;
    final Offset drawMid = Offset.lerp(start, mid, strokeT);
    path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
    path.lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
  } else {
    final double strokeT = (t - 0.5) * 2.0;
    final Offset drawEnd = Offset.lerp(mid, end, strokeT);
    path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
    path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
    path.lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
  }
  canvas.drawPath(path, paint);
}

_drawDash(Canvas canvas, Offset origin, double t, double width, Paint paint) {
  assert(t >= 0.0 && t <= 1.0);
  // As t goes from 0.0 to 1.0, animate the horizontal line from the
  // mid point outwards.
  Offset start = Offset(width * 0.2, width * 0.5);
  Offset mid = Offset(width * 0.5, width * 0.5);
  Offset end = Offset(width * 0.8, width * 0.5);
  Offset drawStart = Offset.lerp(start, mid, 1.0 - t);
  Offset drawEnd = Offset.lerp(mid, end, t);
  canvas.drawLine(origin + drawStart, origin + drawEnd, paint);
}

enum ACECheckBoxType { normal, circle }
