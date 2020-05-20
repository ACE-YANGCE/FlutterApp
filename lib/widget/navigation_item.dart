import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ace_bottom_navigation_bar.dart';

class NavigationItem extends StatelessWidget {
  final UniqueKey uniqueKey;
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
  final Function(UniqueKey uniqueKey) callbackFunction;

  NavigationItem(
      {@required this.uniqueKey,
      @required this.selected,
      @required this.textStr,
      @required this.textSelectedColor,
      @required this.textUnSelectedColor,
      @required this.icon,
      @required this.iconSelectedColor,
      @required this.iconUnSelectedColor,
      @required this.image,
      @required this.imageSelected,
      @required this.callbackFunction,
      @required this.type,
      @required this.isProtruding});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Opacity(
            opacity: isProtruding ? 0.0 : 1.0,
            child: Stack(children: <Widget>[
              Container(
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                      opacity: textOption(),
                      child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(textStr,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? textSelectedColor
                                      : textUnSelectedColor))))),
              Container(
                  child: AnimatedAlign(
                      duration: Duration(milliseconds: 0),
                      alignment: picZoomAlignment(),
                      child: childWid()))
            ])));
  }

  double picSize() {
    var size;
    if (type == ACEBottomNavigationBarType.normal) {
      size = 30.0;
    } else {
      size = selected ? 50.0 : 30.0;
    }
    return size;
  }

  double textOption() {
    var option;
    if (type == ACEBottomNavigationBarType.zoom ||
        type == ACEBottomNavigationBarType.zoomoutonlypic) {
      option = selected ? 0.0 : 1.0;
    } else {
      option = 1.0;
    }
    return option;
  }

  Alignment picZoomAlignment() {
    var alignment;
    if (type == ACEBottomNavigationBarType.normal ||
        type == ACEBottomNavigationBarType.zoom) {
      alignment = Alignment(0, 0);
    } else if (type == ACEBottomNavigationBarType.zoomout) {
      alignment = Alignment(0, (selected) ? -4 : 0);
    } else if (type == ACEBottomNavigationBarType.zoomoutonlypic) {
      alignment = Alignment(0, (selected) ? -2 : 0);
    } else {
      alignment = Alignment(0, 0);
    }
    return alignment;
  }

  EdgeInsetsGeometry imagePadding() {
    EdgeInsetsGeometry edge;
    if (type == ACEBottomNavigationBarType.zoom) {
      edge = selected
          ? EdgeInsets.only(top: 6.0, bottom: 6.0)
          : EdgeInsets.only(bottom: 20.0);
    } else if (type == ACEBottomNavigationBarType.zoomout ||
        type == ACEBottomNavigationBarType.zoomoutonlypic) {
      edge = selected
          ? EdgeInsets.only(bottom: 0.0)
          : EdgeInsets.only(bottom: 20.0);
    } else if (type == ACEBottomNavigationBarType.normal) {
      edge = EdgeInsets.only(bottom: 20.0);
    } else {
      edge = EdgeInsets.only(bottom: 0.0);
    }
    return edge;
  }

  Widget childWid() {
    Widget widget;
    if (image != null) {
      widget = GestureDetector(
          child: Padding(
              padding: imagePadding(),
              child: Image(
                  image: (selected && imageSelected != null)
                      ? imageSelected
                      : image,
                  width: picSize(),
                  height: picSize())),
          onTap: () {
            callbackFunction(uniqueKey);
          });
    } else {
      widget = IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          padding: EdgeInsets.only(bottom: 24.0),
          alignment: Alignment(0, 0),
          icon: Icon(icon,
              size: picSize(),
              color: selected ? iconSelectedColor : iconUnSelectedColor),
          onPressed: () {
            callbackFunction(uniqueKey);
          });
    }
    return widget;
  }
}
