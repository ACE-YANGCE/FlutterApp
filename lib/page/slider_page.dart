import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => new _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  var _value01 = 0.0, _value02 = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Slider Page')),
            body: ListView(children: <Widget>[
              SizedBox(height: 20),
              _itemSlide01(),
              SizedBox(height: 20),
              _itemSlide02(),
              SizedBox(height: 20),
              _itemSlide03(),
              SizedBox(height: 40),
              _itemSlide04(),
              SizedBox(height: 20),
              _itemSlide05(),
              SizedBox(height: 20),
              _itemSlide06(),
              SizedBox(height: 30),
              _itemSlideTheme01(),
              SizedBox(height: 30),
              _itemSlideTheme02(),
              SizedBox(height: 30),
              _itemSlideTheme03(),
              SizedBox(height: 30),
              _itemSlideTheme04(),
              SizedBox(height: 30),
              _itemSlideTheme05(),
              SizedBox(height: 30),
              _itemSlideTheme06(),
            ])));
  }

  _itemSlide01() {
    return Slider(
        value: _value01, onChanged: (val) => setState(() => _value01 = val));
  }

  _itemSlide02() {
    return Slider(
        value: _value02,
        min: 0.0,
        max: 100.0,
        onChanged: (val) => setState(() => _value02 = val));
  }

  _itemSlide03() {
    return Slider(
        value: _value02,
        min: 0.0,
        max: 100.0,
        activeColor: Colors.deepOrange,
        inactiveColor: Colors.grey,
        onChanged: (val) => setState(() => _value02 = val));
  }

  _itemSlide04() {
    return Slider(
        value: _value02,
        min: 0.0,
        max: 100.0,
        activeColor: Colors.deepPurple,
        inactiveColor: Colors.grey,
        divisions: 5,
        label: 'Current Label = $_value02',
        onChanged: (val) => setState(() => _value02 = val));
  }

  _itemSlide05() {
    return Slider(
        value: _value02,
        min: 0.0,
        max: 100.0,
        activeColor: Colors.green,
        inactiveColor: Colors.grey,
        onChangeStart: (val) => print('onChangeStart -> $val'),
        onChangeEnd: (val) => print('onChangeEnd -> $val'),
        onChanged: (val) => setState(() => _value02 = val));
  }

  _itemSlide06() {
    return Slider(
        value: _value02,
        min: 0.0,
        max: 100.0,
        divisions: 5,
        label: 'Current Label = $_value02',
        onChangeStart: (val) => print('onChangeStart -> $val'),
        onChangeEnd: (val) => print('onChangeEnd -> $val'),
        // onChanged: null);
        onChanged: (val) => setState(() => _value02 = val));
  }

  _itemSlideTheme01() {
    return SliderTheme(
        data: SliderThemeData(
            activeTrackColor: Colors.pink, inactiveTrackColor: Colors.grey),
        child: _itemSlide06());
  }

  _itemSlideTheme02() {
    return SliderTheme(
        data: SliderThemeData(
            activeTrackColor: Colors.pink.withOpacity(0.8),
            inactiveTrackColor: Colors.grey,
            thumbColor: Colors.deepPurple,
            overlayColor: Colors.deepPurple.withOpacity(0.3),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0)),
        child: _itemSlide06());
  }

  _itemSlideTheme03() {
    return SliderTheme(
        data: SliderThemeData(
            activeTrackColor: Colors.pink.withOpacity(0.8),
            inactiveTrackColor: Colors.grey,
            thumbColor: Colors.deepPurple,
            overlayColor: Colors.deepPurple.withOpacity(0.3),
            valueIndicatorColor: Colors.deepPurple.withOpacity(0.6),
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorTextStyle: TextStyle(fontSize: 14.0)),
        child: _itemSlide06());
  }

  _itemSlideTheme04() {
    return SliderTheme(
        data: SliderThemeData(
            activeTrackColor: Colors.pink.withOpacity(0.8),
            inactiveTrackColor: Colors.grey,
            thumbColor: Colors.deepPurple,
            overlayColor: Colors.deepPurple.withOpacity(0.3),
            valueIndicatorColor: Colors.deepPurple.withOpacity(0.6),
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorTextStyle: TextStyle(fontSize: 14.0),
            activeTickMarkColor: Colors.deepPurple.withOpacity(0.8),
            inactiveTickMarkColor: Colors.pink.withOpacity(0.4),
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4.0)),
        child: _itemSlide06());
  }

  _itemSlideTheme05() {
    return SliderTheme(
        data: SliderThemeData(
            activeTrackColor: Colors.pink.withOpacity(0.8),
            inactiveTrackColor: Colors.grey,
            thumbColor: Colors.deepPurple,
            overlayColor: Colors.deepPurple.withOpacity(0.3),
            valueIndicatorColor: Colors.deepPurple.withOpacity(0.6),
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorTextStyle: TextStyle(fontSize: 14.0),
            activeTickMarkColor: Colors.deepPurple.withOpacity(0.8),
            inactiveTickMarkColor: Colors.pink.withOpacity(0.4),
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4.0),
            trackHeight: 8.0),
        child: _itemSlide06());
  }

  _itemSlideTheme06() {
    return SliderTheme(
        data: SliderThemeData(
            disabledActiveTrackColor: Colors.deepOrange.withOpacity(0.8),
            disabledInactiveTrackColor: Colors.grey,
            disabledThumbColor: Colors.grey,
            disabledActiveTickMarkColor: Colors.deepOrange.withOpacity(0.8),
            disabledInactiveTickMarkColor: Colors.yellow.withOpacity(0.8),
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4.0),
            trackHeight: 4.0),
        child: Slider(value: 0.6, divisions: 5, onChanged: null));
  }
}
