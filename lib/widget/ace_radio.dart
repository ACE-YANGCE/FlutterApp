import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

const double _kOuterRadius = 8.0;
const double _kInnerRadius = 4.5;

enum ACEMaterialTapTargetSize { padded, shrinkWrap, zero }

class ACERadio<T> extends StatefulWidget {
  const ACERadio(
      {Key key,
      @required this.value,
      @required this.groupValue,
      @required this.onChanged,
      this.activeColor,
      this.focusColor,
      this.hoverColor,
      this.unCheckedColor,
      this.disabledColor,
      this.radioSize,
      this.materialTapTargetSize,
      this.focusNode,
      this.autofocus = false})
      : super(key: key);

  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color activeColor;
  final ACEMaterialTapTargetSize materialTapTargetSize;
  final Color focusColor;
  final Color hoverColor;
  final Color unCheckedColor, disabledColor;
  final double radioSize;
  final FocusNode focusNode;
  final bool autofocus;

  @override
  _RadioState<T> createState() => _RadioState<T>();
}

class _RadioState<T> extends State<ACERadio<T>> with TickerProviderStateMixin {
  bool get enabled => widget.onChanged != null;
  // Map<LocalKey, ActionFactory> _actionMap;

  @override
  void initState() {
    super.initState();
    // _actionMap = <LocalKey, ActionFactory>{
    //   SelectAction.key: _createAction,
    //   if (!kIsWeb) ActivateAction.key: _createAction,
    // };
  }

  void _actionHandler(FocusNode node, Intent intent) {
    if (widget.onChanged != null) {
      widget.onChanged(widget.value);
    }
    final RenderObject renderObject = node.context.findRenderObject();
    renderObject.sendSemanticsEvent(const TapSemanticEvent());
  }

  Action _createAction() {
    // return CallbackAction(SelectAction.key, onInvoke: _actionHandler);
  }

  bool _focused = false;

  void _handleHighlightChanged(bool focused) {
    if (_focused != focused) {
      setState(() => _focused = focused);
    }
  }

  bool _hovering = false;

  void _handleHoverChanged(bool hovering) {
    if (_hovering != hovering) {
      setState(() => _hovering = hovering);
    }
  }

  Color _getInactiveColor(ThemeData themeData) {
    return enabled
        ? widget.unCheckedColor ?? themeData.unselectedWidgetColor
        : widget.disabledColor ?? themeData.disabledColor;
  }

  void _handleChanged(bool selected) {
    if (selected) widget.onChanged(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Size size;
    double radius = widget.radioSize ?? kRadialReactionRadius;
    switch (widget.materialTapTargetSize ?? ACEMaterialTapTargetSize.padded) {
      case ACEMaterialTapTargetSize.padded:
        size = Size(2 * radius + 8.0, 2 * radius + 8.0);
        break;
      case ACEMaterialTapTargetSize.shrinkWrap:
        size = Size(2 * radius, 2 * radius);
        break;
      case ACEMaterialTapTargetSize.zero:
        size = Size(radius, radius);
        break;
    }
    final BoxConstraints additionalConstraints = BoxConstraints.tight(size);
    return FocusableActionDetector(
        actions: null,
        // actions: _actionMap,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: enabled,
        onShowFocusHighlight: _handleHighlightChanged,
        onShowHoverHighlight: _handleHoverChanged,
        child: Builder(builder: (BuildContext context) {
          return _RadioRenderObjectWidget(
              selected: widget.value == widget.groupValue,
              activeColor:
                  widget.activeColor ?? themeData.toggleableActiveColor,
              inactiveColor: _getInactiveColor(themeData),
              focusColor: widget.focusColor ?? themeData.focusColor,
              hoverColor: widget.hoverColor ?? themeData.hoverColor,
              unCheckedColor:
                  widget.unCheckedColor ?? themeData.unselectedWidgetColor,
              disabledColor: widget.disabledColor ?? themeData.disabledColor,
              onChanged: enabled ? _handleChanged : null,
              additionalConstraints: additionalConstraints,
              radioSize: widget.radioSize ?? _kOuterRadius,
              vsync: this,
              hasFocus: _focused,
              hovering: _hovering);
        }));
  }
}

class _RadioRenderObjectWidget extends LeafRenderObjectWidget {
  const _RadioRenderObjectWidget(
      {Key key,
      @required this.selected,
      @required this.activeColor,
      @required this.inactiveColor,
      @required this.focusColor,
      @required this.hoverColor,
      @required this.unCheckedColor,
      @required this.disabledColor,
      @required this.additionalConstraints,
      @required this.radioSize,
      this.onChanged,
      @required this.vsync,
      @required this.hasFocus,
      @required this.hovering})
      : super(key: key);

  final bool selected;
  final bool hasFocus;
  final bool hovering;
  final Color inactiveColor;
  final Color activeColor;
  final Color focusColor;
  final Color hoverColor, unCheckedColor, disabledColor;
  final double radioSize;
  final ValueChanged<bool> onChanged;
  final TickerProvider vsync;
  final BoxConstraints additionalConstraints;

  @override
  _RenderRadio createRenderObject(BuildContext context) => _RenderRadio(
      value: selected,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      onChanged: onChanged,
      vsync: vsync,
      additionalConstraints: additionalConstraints,
      hasFocus: hasFocus,
      hovering: hovering,
      radioSize: radioSize);

  @override
  void updateRenderObject(BuildContext context, _RenderRadio renderObject) {
    renderObject
      ..value = selected
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor
      ..focusColor = focusColor
      ..hoverColor = hoverColor
      ..onChanged = onChanged
      ..additionalConstraints = additionalConstraints
      ..vsync = vsync
      ..hasFocus = hasFocus
      ..hovering = hovering
      ..radioSize = radioSize;
  }
}

class _RenderRadio extends RenderToggleable {
  _RenderRadio(
      {bool value,
      Color activeColor,
      Color inactiveColor,
      Color focusColor,
      Color hoverColor,
      ValueChanged<bool> onChanged,
      BoxConstraints additionalConstraints,
      @required TickerProvider vsync,
      bool hasFocus,
      bool hovering,
      this.radioSize})
      : super(
            value: value,
            tristate: false,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            focusColor: focusColor,
            hoverColor: hoverColor,
            onChanged: onChanged,
            additionalConstraints: additionalConstraints,
            vsync: vsync,
            hasFocus: hasFocus,
            hovering: hovering);
  double radioSize;

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    paintRadialReaction(canvas, offset, size.center(Offset.zero));

    final Offset center = (offset & size).center;
    final Color radioColor = onChanged != null ? activeColor : inactiveColor;

    // Outer circle
    final Paint paint = Paint()
      ..color = Color.lerp(inactiveColor, radioColor, position.value)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radioSize / 4 ?? 2.0;
    canvas.drawCircle(center, radioSize ?? _kOuterRadius, paint);

    // Inner circle
    if (!position.isDismissed) {
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(
          center,
          (radioSize != null ? radioSize * 4.5 / 8 : _kInnerRadius) *
              position.value,
          paint);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isInMutuallyExclusiveGroup = true
      ..isChecked = value == true;
  }
}
