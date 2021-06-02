import 'dart:math' as math;
import 'dart:ui' show window;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = kMinInteractiveDimension;
const double _kDenseButtonHeight = 24.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 16.0);
const EdgeInsetsGeometry _kAlignedButtonPadding =
    EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;
const EdgeInsets _kAlignedMenuMargin = EdgeInsets.zero;
const EdgeInsetsGeometry _kUnalignedMenuMargin =
    EdgeInsetsDirectional.only(start: 16.0, end: 24.0);
const double _kIconCheckedSize = 16.0;

typedef DropdownButtonBuilder = List<Widget> Function(BuildContext context);

class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter(
      {this.color,
      this.elevation,
      this.selectedIndex,
      this.resize,
      this.getSelectedItemOffset,
      this.menuRadius})
      : _painter = BoxDecoration(
                color: color,
                borderRadius: menuRadius ?? BorderRadius.circular(2.0),
                boxShadow: kElevationToShadow[elevation])
            .createBoxPainter(),
        super(repaint: resize);

  final Color color;
  final int elevation;
  final int selectedIndex;
  final Animation<double> resize;
  final ValueGetter<double> getSelectedItemOffset;
  final BoxPainter _painter;
  final BorderRadius menuRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final double selectedItemOffset = getSelectedItemOffset();
    final Tween<double> top = Tween<double>(
        begin: selectedItemOffset.clamp(0.0, size.height - _kMenuItemHeight),
        end: 0.0);

    final Tween<double> bottom = Tween<double>(
        begin:
            (top.begin + _kMenuItemHeight).clamp(_kMenuItemHeight, size.height),
        end: size.height);

    final Rect rect = Rect.fromLTRB(
        0.0, top.evaluate(resize), size.width, bottom.evaluate(resize));

    _painter.paint(canvas, rect.topLeft, ImageConfiguration(size: rect.size));
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.elevation != elevation ||
        oldPainter.selectedIndex != selectedIndex ||
        oldPainter.resize != resize;
  }
}

class _DropdownScrollBehavior extends ScrollBehavior {
  const _DropdownScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) =>
      Theme.of(context).platform;

  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

class _DropdownMenuItemButton<T> extends StatefulWidget {
  const _DropdownMenuItemButton(
      {Key key,
      @required this.padding,
      @required this.route,
      @required this.buttonRect,
      @required this.constraints,
      @required this.itemIndex})
      : super(key: key);

  final _DropdownRoute<T> route;
  final EdgeInsets padding;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final int itemIndex;

  @override
  _DropdownMenuItemButtonState<T> createState() =>
      _DropdownMenuItemButtonState<T>();
}

class _DropdownMenuItemButtonState<T>
    extends State<_DropdownMenuItemButton<T>> {
  void _handleFocusChange(bool focused) {
    bool inTraditionalMode;
    switch (FocusManager.instance.highlightMode) {
      case FocusHighlightMode.touch:
        inTraditionalMode = false;
        break;
      case FocusHighlightMode.traditional:
        inTraditionalMode = true;
        break;
    }

    if (focused && inTraditionalMode) {
      final _MenuLimits menuLimits = widget.route.getMenuLimits(
          widget.buttonRect, widget.constraints.maxHeight, widget.itemIndex);
      widget.route.scrollController.animateTo(menuLimits.scrollOffset,
          curve: Curves.easeInOut, duration: const Duration(milliseconds: 100));
    }
  }

  void _handleOnTap() {
    Navigator.pop(
        context,
        _DropdownRouteResult<T>(
            widget.route.items[widget.itemIndex].item.value));
  }

  static final Map<LogicalKeySet, Intent> _webShortcuts =
      <LogicalKeySet, Intent>{
    // LogicalKeySet(LogicalKeyboardKey.enter): const Intent(SelectAction.key)
  };

  @override
  Widget build(BuildContext context) {
    CurvedAnimation opacity;
    final double unit = 0.5 / (widget.route.items.length + 1.5);
    if (widget.itemIndex == widget.route.selectedIndex) {
      opacity = CurvedAnimation(
          parent: widget.route.animation, curve: const Threshold(0.0));
    } else {
      final double start =
          (0.5 + (widget.itemIndex + 1) * unit).clamp(0.0, 1.0);
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      opacity = CurvedAnimation(
          parent: widget.route.animation, curve: Interval(start, end));
    }
    Widget child = FadeTransition(
        opacity: opacity,
        child: InkWell(
            autofocus: widget.itemIndex == widget.route.selectedIndex,
            child: Container(
                padding: widget.padding,
                child: Row(children: <Widget>[
                  Expanded(child: widget.route.items[widget.itemIndex]),
                  widget.route.isChecked == true &&
                          widget.itemIndex == widget.route.selectedIndex
                      ? (widget.route.iconChecked ??
                          Icon(Icons.check, size: _kIconCheckedSize))
                      : Container()
                ])),
            onTap: _handleOnTap,
            onFocusChange: _handleFocusChange));
    if (kIsWeb) {
      child = Shortcuts(shortcuts: _webShortcuts, child: child);
    }
    return child;
  }
}

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu(
      {Key key, this.padding, this.route, this.buttonRect, this.constraints})
      : super(key: key);

  final _DropdownRoute<T> route;
  final EdgeInsets padding;
  final Rect buttonRect;
  final BoxConstraints constraints;

  @override
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  CurvedAnimation _fadeOpacity;
  CurvedAnimation _resize;

  @override
  void initState() {
    super.initState();
    _fadeOpacity = CurvedAnimation(
        parent: widget.route.animation,
        curve: const Interval(0.0, 0.25),
        reverseCurve: const Interval(0.75, 1.0));
    _resize = CurvedAnimation(
        parent: widget.route.animation,
        curve: const Interval(0.25, 0.5),
        reverseCurve: const Threshold(0.0));
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route;
    final List<Widget> children = <Widget>[
      for (int itemIndex = 0; itemIndex < route.items.length; ++itemIndex)
        _DropdownMenuItemButton<T>(
          route: widget.route,
          padding: widget.padding,
          buttonRect: widget.buttonRect,
          constraints: widget.constraints,
          itemIndex: itemIndex,
        ),
    ];

    return FadeTransition(
        opacity: _fadeOpacity,
        child: CustomPaint(
            painter: _DropdownMenuPainter(
                color: route.backgroundColor ?? Theme.of(context).canvasColor,
                menuRadius: route.menuRadius,
                elevation: route.elevation,
                selectedIndex: route.selectedIndex,
                resize: _resize,
                getSelectedItemOffset: () => route.getItemOffset(0)),
            child: Semantics(
                scopesRoute: true,
                namesRoute: true,
                explicitChildNodes: true,
                label: localizations.popupMenuLabel,
                child: Material(
                    type: MaterialType.transparency,
                    textStyle: route.style,
                    child: ScrollConfiguration(
                        behavior: const _DropdownScrollBehavior(),
                        child: Scrollbar(
                            child: ListView(
                                controller: widget.route.scrollController,
                                padding: kMaterialListPadding,
                                shrinkWrap: true,
                                children: children)))))));
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout(
      {@required this.buttonRect,
      @required this.route,
      @required this.textDirection});

  final Rect buttonRect;
  final _DropdownRoute<T> route;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxHeight =
        math.max(0.0, constraints.maxHeight - 2 * _kMenuItemHeight);
    final double width = math.min(constraints.maxWidth, buttonRect.width);
    return BoxConstraints(
        minWidth: width, maxWidth: width, minHeight: 0.0, maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final _MenuLimits menuLimits =
        route.getMenuLimits(buttonRect, size.height, route.selectedIndex);

    double left;
    switch (textDirection) {
      case TextDirection.rtl:
        left = buttonRect.right.clamp(0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = buttonRect.left.clamp(0.0, size.width - childSize.width);
        break;
    }

    return Offset(left, menuLimits.top);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        textDirection != oldDelegate.textDirection;
  }
}

class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T result;

  @override
  bool operator ==(dynamic other) {
    if (other is! _DropdownRouteResult<T>) return false;
    final _DropdownRouteResult<T> typedOther = other;
    return result == typedOther.result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _MenuLimits {
  const _MenuLimits(this.top, this.bottom, this.height, this.scrollOffset);

  final double top, bottom, height, scrollOffset;
}

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
  _DropdownRoute(
      {this.items,
      this.padding,
      this.buttonRect,
      this.selectedIndex,
      this.elevation = 8,
      this.theme,
      @required this.style,
      this.barrierLabel,
      this.itemHeight,
      this.backgroundColor,
      this.menuRadius,
      this.isChecked,
      this.iconChecked})
      : itemHeights = List<double>.filled(
            items.length, itemHeight ?? kMinInteractiveDimension);

  final List<_MenuItem<T>> items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final ThemeData theme;
  final TextStyle style;
  final double itemHeight;
  final Color backgroundColor;
  final BorderRadius menuRadius;
  final bool isChecked;
  final Icon iconChecked;
  final List<double> itemHeights;
  ScrollController scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _DropdownRoutePage<T>(
          route: this,
          constraints: constraints,
          items: items,
          padding: padding,
          buttonRect: buttonRect,
          selectedIndex: selectedIndex,
          elevation: elevation,
          theme: theme,
          style: style);
    });
  }

  void _dismiss() => navigator?.removeRoute(this);

  double getItemOffset(int index) {
    double offset = kMaterialListPadding.top;
    if (items.isNotEmpty && index > 0) {
      assert(items.length == itemHeights?.length);
      offset += itemHeights
          .sublist(0, index)
          .reduce((double total, double height) => total + height);
    }
    return offset;
  }

  _MenuLimits getMenuLimits(
      Rect buttonRect, double availableHeight, int index) {
    final double maxMenuHeight = availableHeight - 2.0 * _kMenuItemHeight;
    final double buttonTop = buttonRect.top;
    final double buttonBottom = math.min(buttonRect.bottom, availableHeight);
    final double selectedItemOffset = getItemOffset(index);
    final double topLimit = math.min(_kMenuItemHeight, buttonTop);
    final double bottomLimit =
        math.max(availableHeight - _kMenuItemHeight, buttonBottom);

    double menuTop = (buttonTop - selectedItemOffset) -
        (itemHeights[selectedIndex] - buttonRect.height) / 2.0;
    double preferredMenuHeight = kMaterialListPadding.vertical;
    if (items.isNotEmpty)
      preferredMenuHeight +=
          itemHeights.reduce((double total, double height) => total + height);

    final double menuHeight = math.min(maxMenuHeight, preferredMenuHeight);
    if (bottomLimit - buttonRect.bottom < menuHeight) {
      menuTop = buttonRect.top - menuHeight;
    } else {
      menuTop = buttonRect.bottom;
    }
    double menuBottom = menuTop + menuHeight;
    if (menuTop < topLimit) menuTop = math.min(buttonTop, topLimit);

    if (menuBottom > bottomLimit) {
      menuBottom = math.max(buttonBottom, bottomLimit);
      menuTop = menuBottom - menuHeight;
    }

    final double scrollOffset = preferredMenuHeight <= maxMenuHeight
        ? 0
        : math.max(0.0, selectedItemOffset - (buttonTop - menuTop));

    return _MenuLimits(menuTop, menuBottom, menuHeight, scrollOffset);
  }
}

class _DropdownRoutePage<T> extends StatelessWidget {
  const _DropdownRoutePage(
      {Key key,
      this.route,
      this.constraints,
      this.items,
      this.padding,
      this.buttonRect,
      this.selectedIndex,
      this.elevation = 8,
      this.theme,
      this.style})
      : super(key: key);

  final _DropdownRoute<T> route;
  final BoxConstraints constraints;
  final List<_MenuItem<T>> items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final ThemeData theme;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    if (route.scrollController == null) {
      final _MenuLimits menuLimits =
          route.getMenuLimits(buttonRect, constraints.maxHeight, selectedIndex);
      route.scrollController =
          ScrollController(initialScrollOffset: menuLimits.scrollOffset);
    }

    final TextDirection textDirection = Directionality.of(context);
    Widget menu = _DropdownMenu<T>(
        route: route,
        padding: padding.resolve(textDirection),
        buttonRect: buttonRect,
        constraints: constraints);

    if (theme != null) menu = Theme(data: theme, child: menu);

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        child: Builder(builder: (BuildContext context) {
          return CustomSingleChildLayout(
              delegate: _DropdownMenuRouteLayout<T>(
                  buttonRect: buttonRect,
                  route: route,
                  textDirection: textDirection),
              child: menu);
        }));
  }
}

class _MenuItem<T> extends SingleChildRenderObjectWidget {
  const _MenuItem({Key key, @required this.onLayout, @required this.item})
      : assert(onLayout != null),
        super(key: key, child: item);

  final ValueChanged<Size> onLayout;
  final ACEDropdownMenuItem<T> item;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderProxyBox {
  _RenderMenuItem(this.onLayout, [RenderBox child])
      : assert(onLayout != null),
        super(child);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}

class _DropdownMenuItemContainer extends StatelessWidget {
  const _DropdownMenuItemContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(minHeight: _kMenuItemHeight),
        alignment: AlignmentDirectional.centerStart,
        child: child);
  }
}

class ACEDropdownMenuItem<T> extends _DropdownMenuItemContainer {
  const ACEDropdownMenuItem({Key key, this.value, @required Widget child})
      : super(key: key, child: child);

  final T value;
}

/// An inherited widget that causes any descendant [DropdownButton]
/// widgets to not include their regular underline.
///
/// This is used by [DataTable] to remove the underline from any
/// [DropdownButton] widgets placed within material data tables, as
/// required by the material design specification.
class DropdownButtonHideUnderline extends InheritedWidget {
  /// Creates a [DropdownButtonHideUnderline]. A non-null [child] must
  /// be given.
  const DropdownButtonHideUnderline({
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  /// Returns whether the underline of [DropdownButton] widgets should
  /// be hidden.
  static bool at(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
            DropdownButtonHideUnderline>() !=
        null;
  }

  @override
  bool updateShouldNotify(DropdownButtonHideUnderline oldWidget) => false;
}

class ACEDropdownButton<T> extends StatefulWidget {
  ACEDropdownButton(
      {Key key,
      @required this.items,
      this.selectedItemBuilder,
      this.value,
      this.hint,
      this.disabledHint,
      @required this.onChanged,
      this.elevation = 8,
      this.style,
      this.underline,
      this.icon,
      this.iconDisabledColor,
      this.iconEnabledColor,
      this.iconSize = 24.0,
      this.isDense = false,
      this.isExpanded = false,
      this.itemHeight = kMinInteractiveDimension,
      this.focusColor,
      this.focusNode,
      this.autofocus = false,
      this.backgroundColor,
      this.menuRadius,
      this.isChecked,
      this.iconChecked})
      : super(key: key);

  final List<ACEDropdownMenuItem<T>> items;
  final T value;
  final Widget hint;
  final Widget disabledHint;
  final ValueChanged<T> onChanged;
  final DropdownButtonBuilder selectedItemBuilder;
  final int elevation;
  final TextStyle style;
  final Widget underline;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double itemHeight;
  final Color focusColor;
  final FocusNode focusNode;
  final bool autofocus;
  final Color backgroundColor;
  final BorderRadius menuRadius;
  final bool isChecked;
  final Icon iconChecked;

  @override
  _DropdownButtonState<T> createState() => _DropdownButtonState<T>();
}

class _DropdownButtonState<T> extends State<ACEDropdownButton<T>>
    with WidgetsBindingObserver {
  int _selectedIndex;
  _DropdownRoute<T> _dropdownRoute;
  Orientation _lastOrientation;
  FocusNode _internalNode;

  FocusNode get focusNode => widget.focusNode ?? _internalNode;
  bool _hasPrimaryFocus = false;
  // Map<LocalKey, ActionFactory> _actionMap;
  Map<Type, Action<Intent>> _actionMap;
  FocusHighlightMode _focusHighlightMode;

  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    // _actionMap = <LocalKey, ActionFactory>{
    //   SelectAction.key: _createAction,
    //   if (!kIsWeb) ActivateAction.key: _createAction,
    // };
    focusNode.addListener(_handleFocusChanged);
    final FocusManager focusManager = WidgetsBinding.instance.focusManager;
    _focusHighlightMode = focusManager.highlightMode;
    focusManager.addHighlightModeListener(_handleFocusHighlightModeChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeDropdownRoute();
    WidgetsBinding.instance.focusManager
        .removeHighlightModeListener(_handleFocusHighlightModeChange);
    focusNode.removeListener(_handleFocusChanged);
    _internalNode?.dispose();
    super.dispose();
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
    _lastOrientation = null;
  }

  void _handleFocusChanged() {
    if (_hasPrimaryFocus != focusNode.hasPrimaryFocus) {
      setState(() {
        _hasPrimaryFocus = focusNode.hasPrimaryFocus;
      });
    }
  }

  void _handleFocusHighlightModeChange(FocusHighlightMode mode) {
    if (!mounted) {
      return;
    }
    setState(() {
      _focusHighlightMode = mode;
    });
  }

  @override
  void didUpdateWidget(ACEDropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      if (widget.focusNode == null) {
        _internalNode ??= _createFocusNode();
      }
      _hasPrimaryFocus = focusNode.hasPrimaryFocus;
      focusNode.addListener(_handleFocusChanged);
    }
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    if (!_enabled) {
      return;
    }
    _selectedIndex = null;
    for (int itemIndex = 0; itemIndex < widget.items.length; itemIndex++) {
      if (widget.items[itemIndex].value == widget.value) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  TextStyle get _textStyle =>
      widget.style ?? Theme.of(context).textTheme.subhead;

  void _handleTap() {
    final RenderBox itemBox = context.findRenderObject();
    final Rect itemRect = itemBox.localToGlobal(Offset.zero) & itemBox.size;
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsetsGeometry menuMargin =
        ButtonTheme.of(context).alignedDropdown
            ? _kAlignedMenuMargin
            : _kUnalignedMenuMargin;

    final List<_MenuItem<T>> menuItems =
        List<_MenuItem<T>>(widget.items.length);
    for (int index = 0; index < widget.items.length; index += 1) {
      menuItems[index] = _MenuItem<T>(
          item: widget.items[index],
          onLayout: (Size size) {
            _dropdownRoute.itemHeights[index] = size.height;
          });
    }

    _dropdownRoute = _DropdownRoute<T>(
        items: menuItems,
        buttonRect: menuMargin.resolve(textDirection).inflateRect(itemRect),
        padding: _kMenuItemPadding.resolve(textDirection),
        selectedIndex: _selectedIndex ?? 0,
        elevation: widget.elevation,
        theme: Theme.of(context, shadowThemeOnly: true),
        style: _textStyle,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        itemHeight: widget.itemHeight,
        backgroundColor: widget.backgroundColor,
        menuRadius: widget.menuRadius,
        isChecked: widget.isChecked,
        iconChecked: widget.iconChecked);

    Navigator.push(context, _dropdownRoute)
        .then<void>((_DropdownRouteResult<T> newValue) {
      _dropdownRoute = null;
      if (!mounted || newValue == null) return;
      if (widget.onChanged != null) widget.onChanged(newValue.result);
    });
  }

  Action _createAction() {
    // return CallbackAction(ActivateAction.key,
    //     onInvoke: (FocusNode node, Intent intent) {
    //   _handleTap();
    // });
  }

  double get _denseButtonHeight {
    final double fontSize =
        _textStyle.fontSize ?? Theme.of(context).textTheme.subhead.fontSize;
    return math.max(fontSize, math.max(widget.iconSize, _kDenseButtonHeight));
  }

  Color get _iconColor {
    if (_enabled) {
      if (widget.iconEnabledColor != null) return widget.iconEnabledColor;

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade700;
        case Brightness.dark:
          return Colors.white70;
      }
    } else {
      if (widget.iconDisabledColor != null) return widget.iconDisabledColor;

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade400;
        case Brightness.dark:
          return Colors.white10;
      }
    }
    return null;
  }

  bool get _enabled =>
      widget.items != null &&
      widget.items.isNotEmpty &&
      widget.onChanged != null;

  Orientation _getOrientation(BuildContext context) {
    Orientation result = MediaQuery.of(context, nullOk: true)?.orientation;
    if (result == null) {
      final Size size = window.physicalSize;
      result = size.width > size.height
          ? Orientation.landscape
          : Orientation.portrait;
    }
    return result;
  }

  bool get _showHighlight {
    switch (_focusHighlightMode) {
      case FocusHighlightMode.touch:
        return false;
      case FocusHighlightMode.traditional:
        return _hasPrimaryFocus;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Orientation newOrientation = _getOrientation(context);
    _lastOrientation ??= newOrientation;
    if (newOrientation != _lastOrientation) {
      _removeDropdownRoute();
      _lastOrientation = newOrientation;
    }

    List<Widget> items;
    if (_enabled) {
      items = widget.selectedItemBuilder == null
          ? List<Widget>.from(widget.items)
          : widget.selectedItemBuilder(context);
    } else {
      items = widget.selectedItemBuilder == null
          ? <Widget>[]
          : widget.selectedItemBuilder(context);
    }

    int hintIndex;
    if (widget.hint != null || (!_enabled && widget.disabledHint != null)) {
      Widget displayedHint =
          _enabled ? widget.hint : widget.disabledHint ?? widget.hint;
      if (widget.selectedItemBuilder == null)
        displayedHint = _DropdownMenuItemContainer(child: displayedHint);

      hintIndex = items.length;
      items.add(DefaultTextStyle(
          style: _textStyle.copyWith(color: Theme.of(context).hintColor),
          child:
              IgnorePointer(ignoringSemantics: false, child: displayedHint)));
    }

    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _kAlignedButtonPadding
        : _kUnalignedButtonPadding;

    final int index = _enabled ? (_selectedIndex ?? hintIndex) : hintIndex;
    Widget innerItemsWidget;
    if (items.isEmpty) {
      innerItemsWidget = Container();
    } else {
      innerItemsWidget = IndexedStack(
          index: index,
          alignment: AlignmentDirectional.centerStart,
          children: widget.isDense
              ? items
              : items.map((Widget item) {
                  return widget.itemHeight != null
                      ? SizedBox(height: widget.itemHeight, child: item)
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[item]);
                }).toList());
    }

    const Icon defaultIcon = Icon(Icons.arrow_drop_down);

    Widget result = DefaultTextStyle(
        style: _textStyle,
        child: Container(
            decoration: _showHighlight
                ? BoxDecoration(
                    color: widget.focusColor ?? Theme.of(context).focusColor,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)))
                : null,
            padding: padding.resolve(Directionality.of(context)),
            height: widget.isDense ? _denseButtonHeight : null,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (widget.isExpanded)
                    Expanded(child: innerItemsWidget)
                  else
                    innerItemsWidget,
                  IconTheme(
                      data: IconThemeData(
                          color: _iconColor, size: widget.iconSize),
                      child: widget.icon ?? defaultIcon)
                ])));

    if (!DropdownButtonHideUnderline.at(context)) {
      final double bottom =
          (widget.isDense || widget.itemHeight == null) ? 0.0 : 8.0;
      result = Stack(children: <Widget>[
        result,
        Positioned(
            left: 0.0,
            right: 0.0,
            bottom: bottom,
            child: widget.underline ??
                Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFBDBDBD), width: 0.0)))))
      ]);
    }

    return Semantics(
        button: true,
        child: Actions(
            // actions: _actionMap,
            actions: null,
            child: Focus(
                canRequestFocus: _enabled,
                focusNode: focusNode,
                autofocus: widget.autofocus,
                child: GestureDetector(
                    onTap: _enabled ? _handleTap : null,
                    behavior: HitTestBehavior.opaque,
                    child: result))));
  }
}

/// A convenience widget that wraps a [ACEDropdownButton] in a [FormField].
class DropdownButtonFormField<T> extends FormField<T> {
  /// Creates a [ACEDropdownButton] widget wrapped in an [InputDecorator] and
  /// [FormField].
  ///
  /// The [ACEDropdownButton] [items] parameters must not be null.
  DropdownButtonFormField(
      {Key key,
      T value,
      @required List<ACEDropdownMenuItem<T>> items,
      DropdownButtonBuilder selectedItemBuilder,
      Widget hint,
      @required this.onChanged,
      this.decoration = const InputDecoration(),
      FormFieldSetter<T> onSaved,
      FormFieldValidator<T> validator,
      bool autovalidate = false,
      Widget disabledHint,
      int elevation = 8,
      TextStyle style,
      Widget icon,
      Color iconDisabledColor,
      Color iconEnabledColor,
      double iconSize = 24.0,
      bool isDense = false,
      bool isExpanded = false,
      double itemHeight})
      : super(
            key: key,
            onSaved: onSaved,
            initialValue: value,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<T> field) {
              final InputDecoration effectiveDecoration = decoration
                  .applyDefaults(Theme.of(field.context).inputDecorationTheme);
              return InputDecorator(
                  decoration:
                      effectiveDecoration.copyWith(errorText: field.errorText),
                  isEmpty: value == null,
                  child: DropdownButtonHideUnderline(
                      child: ACEDropdownButton<T>(
                          value: value,
                          items: items,
                          selectedItemBuilder: selectedItemBuilder,
                          hint: hint,
                          onChanged: onChanged == null ? null : field.didChange,
                          disabledHint: disabledHint,
                          elevation: elevation,
                          style: style,
                          icon: icon,
                          iconDisabledColor: iconDisabledColor,
                          iconEnabledColor: iconEnabledColor,
                          iconSize: iconSize,
                          isDense: isDense,
                          isExpanded: isExpanded,
                          itemHeight: itemHeight)));
            });

  /// {@macro flutter.material.dropdownButton.onChanged}
  final ValueChanged<T> onChanged;

  /// The decoration to show around the dropdown button form field.
  ///
  /// By default, draws a horizontal line under the dropdown button field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  @override
  FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
}

class _DropdownButtonFormFieldState<T> extends FormFieldState<T> {
  @override
  DropdownButtonFormField<T> get widget => super.widget;

  @override
  void didChange(T value) {
    super.didChange(value);
    assert(widget.onChanged != null);
    widget.onChanged(value);
  }
}
