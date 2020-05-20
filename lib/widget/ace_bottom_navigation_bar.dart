import 'package:flutter/material.dart';
import 'package:flutter_app/widget/navigation_item.dart';

enum ACEBottomNavigationBarType {
  normal,
  zoom,
  zoomout,
  zoomoutonlypic,
  protruding
}

class ACEBottomNavigationBar extends StatefulWidget {
  final Key key;
  final List<NavigationItemBean> items;
  final initSelectedIndex;
  final bgColor;
  final bgImage;
  final Function(int position) onTabChangedListener;
  final textStr;
  final textUnSelectedColor;
  final textSelectedColor;
  final icon;
  final iconUnSelectedColor;
  final iconSelectedColor;
  final image;
  final imageSelected;
  final protrudingColor;
  final ACEBottomNavigationBarType type;

  ACEBottomNavigationBar(
      {@required this.items,
      @required this.onTabChangedListener,
      ACEBottomNavigationBarType type,
      this.key,
      this.initSelectedIndex = 0,
      this.textStr,
      this.textSelectedColor,
      this.textUnSelectedColor,
      this.icon,
      this.iconSelectedColor,
      this.iconUnSelectedColor,
      this.image,
      this.imageSelected,
      this.bgColor,
      this.bgImage,
      this.protrudingColor})
      : assert(onTabChangedListener != null),
        assert(items != null),
        assert(items.length >= 1 && items.length <= 5),
        type = type;

  @override
  _ACEBottomNavigationBar createState() => _ACEBottomNavigationBar();
}

class _ACEBottomNavigationBar extends State<ACEBottomNavigationBar>
    with TickerProviderStateMixin, RouteAware {
  var curSelectedIndex = 0;
  var textSelectedColor;
  var textUnSelectedColor;
  var iconSelectedColor;
  var iconUnSelectedColor;
  var protrudingIndex = -1;

  @override
  void initState() {
    super.initState();
    _setSelected(widget.items[widget.initSelectedIndex].key);
  }

  _setSelected(UniqueKey key) {
    if (mounted) {
      setState(() {
        curSelectedIndex =
            widget.items.indexWhere((tabData) => tabData.key == key);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    textUnSelectedColor = (widget.textUnSelectedColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Colors.black54
        : widget.textUnSelectedColor;
    textSelectedColor = (widget.textSelectedColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Colors.black87
        : widget.textSelectedColor;
    iconUnSelectedColor = (widget.iconUnSelectedColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Colors.black54
        : widget.iconUnSelectedColor;
    iconSelectedColor = (widget.iconSelectedColor == null)
        ? (Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Colors.black87
        : widget.iconSelectedColor;

    if (widget.items.length == 1) {
      protrudingIndex = 0;
    } else if (widget.items.length == 3) {
      protrudingIndex = 1;
    } else if (widget.items.length == 5) {
      protrudingIndex = 2;
    } else {
      protrudingIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
              height: 60.0,
              decoration: navigationBarBg(),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.items
                      .map((item) => NavigationItem(
                          uniqueKey: item.key,
                          selected:
                              item.key == widget.items[curSelectedIndex].key,
                          icon: item.icon,
                          textStr: item.textStr,
                          textSelectedColor: (item.textSelectedColor == null)
                              ? this.textSelectedColor
                              : item.textSelectedColor,
                          textUnSelectedColor:
                              (item.textUnSelectedColor == null)
                                  ? this.textUnSelectedColor
                                  : item.textUnSelectedColor,
                          iconSelectedColor: (item.iconSelectedColor == null)
                              ? this.iconSelectedColor
                              : item.iconSelectedColor,
                          iconUnSelectedColor:
                              (item.iconUnSelectedColor == null)
                                  ? this.iconUnSelectedColor
                                  : item.iconUnSelectedColor,
                          type: widget.type != null
                              ? (widget.type ==
                                      ACEBottomNavigationBarType.protruding)
                                  ? ACEBottomNavigationBarType.normal
                                  : widget.type
                              : ACEBottomNavigationBarType.normal,
                          image: item.image,
                          imageSelected: item.imageSelected,
                          isProtruding: (protrudingIndex != -1 &&
                                  widget.type ==
                                      ACEBottomNavigationBarType.protruding &&
                                  widget.items.indexOf(item) == protrudingIndex)
                              ? true
                              : false,
                          callbackFunction: (uniqueKey) {
                            int selected = widget.items.indexWhere(
                                (tabData) => tabData.key == uniqueKey);
                            widget.onTabChangedListener(selected);
                            _setSelected(uniqueKey);
                          }))
                      .toList())),
          protrudingWid()
        ]);
  }

  BoxDecoration navigationBarBg() {
    return widget.bgImage != null
        ? BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
          ], image: DecorationImage(fit: BoxFit.cover, image: widget.bgImage))
        : BoxDecoration(
            color: widget.bgColor != null ? widget.bgColor : Colors.white,
            boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
              ]);
  }

  Widget protrudingWid() {
    Widget proWid;
    if (widget.items.length % 2 == 0 ||
        widget.type != ACEBottomNavigationBarType.protruding) {
      proWid = Container(width: 0.0, height: 0.0);
    } else {
      proWid = Positioned.fill(
          top: -30,
          child: Container(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    SizedBox(
                        height: 60.0,
                        width: 60.0,
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.protrudingColor != null
                                    ? widget.protrudingColor
                                    : Colors.white),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: protrudingItemWid(
                                    widget.items[protrudingIndex]))))
                  ]))));
    }
    return proWid;
  }

  Widget protrudingItemWid(NavigationItemBean item) {
    Widget itemWidget;

    if (item.image != null) {
      itemWidget = GestureDetector(
          child: Image(image: item.image),
          onTap: () {
            widget.onTabChangedListener(protrudingIndex);
            _setSelected(item.key);
          });
    } else {
      itemWidget = IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          alignment: Alignment(0, 0),
          icon: Icon(
            item.icon,
            size: 40.0,
            color: item.iconUnSelectedColor,
          ),
          onPressed: () {
            widget.onTabChangedListener(protrudingIndex);
            _setSelected(item.key);
          });
    }
    return itemWidget;
  }
}

class NavigationItemBean {
  final textStr;
  final textUnSelectedColor;
  final textSelectedColor;
  final icon;
  final iconUnSelectedColor;
  final iconSelectedColor;
  final image;
  final imageSelected;
  final selected;
  final isProtruding;
  final ACEBottomNavigationBarType type;

  NavigationItemBean(
      {@required this.selected,
      @required this.textStr,
      @required this.textSelectedColor,
      @required this.textUnSelectedColor,
      @required this.icon,
      @required this.iconSelectedColor,
      @required this.iconUnSelectedColor,
      @required this.image,
      @required this.imageSelected,
      @required this.type,
      @required this.isProtruding});

  final UniqueKey key = UniqueKey();
}
