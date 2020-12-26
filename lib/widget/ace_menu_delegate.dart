import 'package:flutter/material.dart';
import 'package:flutter_app/menu/menu_enum.dart';
import 'package:flutter_app/utils/screen_utils.dart';

class ACEMenuDelegate extends SingleChildLayoutDelegate {
  final MenuType _menuType;
  final double _controllerValue;

  ACEMenuDelegate(this._menuType, this._controllerValue);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth:
          (_menuType == MenuType.MENU_LEFT || _menuType == MenuType.MENU_RIGHT)
              ? 0
              : constraints.maxWidth,
      maxWidth:
          (_menuType == MenuType.MENU_LEFT || _menuType == MenuType.MENU_RIGHT)
              ? (ScreenUtils.getOrientation() == Orientation.portrait
                  ? ScreenUtils.getScreenWidth() * 0.75
                  : ScreenUtils.getScreenWidth() * 0.35)
              : constraints.maxWidth,
      minHeight: 0.0,
      maxHeight:
          (_menuType == MenuType.MENU_LEFT || _menuType == MenuType.MENU_RIGHT)
              ? constraints.maxHeight
              : constraints.maxHeight * 0.45,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double _offsetX = Offset.zero.dx, _offsetY = Offset.zero.dy;
    switch (_menuType) {
      case MenuType.MENU_TOP:
        _offsetY = -childSize.height * (1 - _controllerValue);
        break;
      case MenuType.MENU_BOTTOM:
        _offsetY = size.height - childSize.height * _controllerValue;
        break;
      case MenuType.MENU_LEFT:
        _offsetX = -childSize.width * (1 - _controllerValue);
        break;
      case MenuType.MENU_RIGHT:
        _offsetX = size.width - childSize.width * _controllerValue;
        break;
      case MenuType.MENU_MIX:
        // TODO: Handle this case.
        break;
      case MenuType.MENU_CLOSE:
        // TODO: Handle this case.
        break;
    }
    return Offset(_offsetX, _offsetY);
  }

  @override
  bool shouldRelayout(ACEMenuDelegate oldDelegate) {
    return _controllerValue != oldDelegate._controllerValue;
  }
}
