import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class ColorEvent {}

class ColorBloc extends Bloc<ColorEvent, Color> {
  @override
  Color get initialState => Colors.white.withOpacity(0.4);

  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    var randomNum = Random().nextInt(10) % 3;
    switch (randomNum) {
      case 0:
        yield state.withRed(200).withGreen(200).withBlue(200);
        break;
      case 1:
        yield state.withRed(100).withGreen(100).withBlue(100);
        break;
      case 2:
        yield state.withRed(50).withGreen(50).withBlue(50);
        break;
    }
  }
}
