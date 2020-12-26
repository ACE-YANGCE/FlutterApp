import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenUtils {
  static double getScreenHeight() {
    return MediaQueryData.fromWindow(window).size.height;
  }

  static double getScreenWidth() {
    return MediaQueryData.fromWindow(window).size.width;
  }

  static Orientation getOrientation() {
    Orientation result = MediaQueryData.fromWindow(window)?.orientation;
    if (result == null) {
      final Size size = window.physicalSize;
      result = size.width > size.height
          ? Orientation.landscape
          : Orientation.portrait;
    }
    return result;
  }
}
